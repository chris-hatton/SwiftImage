//
//  CVImageBufferRef+Extensions.swift
//  ResistAR
//
//  Created by Christopher Hatton on 06/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation
import CoreMedia
import CoreImage
import Accelerate

extension CVPixelBuffer : MutableImage
{
    typealias PixelType   = RGBPixel
    typealias PixelSource = ()->PixelType?
    
    func readRegion( region: ImageRegion ) -> PixelSource
    {
        assert( CVPixelBufferGetPixelFormatType( self ) == kCVPixelFormatType_32BGRA, "This function supports only 32BGRA formatted buffers")
        
        CVPixelBufferLockBaseAddress( self, 0 );
        
        let
            baseAddress   = CVPixelBufferGetBaseAddress( self ),
            bytesPerRow   = CVPixelBufferGetBytesPerRow( self ),
            bytesPerPixel = Int( self.width )
        
        assert( bytesPerPixel == 4, "Expected 4 bytes per pixel" )
        
        let
            pixelPtr         = UnsafeMutablePointer<UInt8>( baseAddress ),
            firstPixelOffset = Int( ( region.y * UInt( bytesPerRow ) ) + ( region.x * UInt( bytesPerPixel ) ) ),
            nextLineOffset   = Int( self.width - region.width ) * ( bytesPerPixel - 1 )
        
        pixelPtr.advancedBy( firstPixelOffset )
        
        let nextLine : ()->Void = { pixelPtr.advancedBy( nextLineOffset ) }
        
        let nextPixel : ()->PixelType =
        {
            let r : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(1)
            let g : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(1)
            let b : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(2)
            
            return RGBPixel(r,g,b)
        }
        
        let end : ()->Void = { CVPixelBufferUnlockBaseAddress(self,0) }
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine, end: end )
    }
    
    func writeRegion( region: ImageRegion, pixelSource: PixelSource )
    {
        assert( CVPixelBufferGetPixelFormatType(self) == kCVPixelFormatType_32BGRA, "This function supports only 32BGRA formatted buffers")
        
        CVPixelBufferLockBaseAddress( self, 0 )
        
        let
            baseAddress   = CVPixelBufferGetBaseAddress( self ),
            bytesPerRow   = CVPixelBufferGetBytesPerRow( self ),
            bytesPerPixel = UInt( bytesPerRow / Int( self.width ) )
            
        assert( bytesPerPixel == 4, "Expected 4 bytes per pixel" )
        
        let
            pixelPointer = UnsafeMutablePointer<UInt8>(baseAddress),
            pixelOffset  = ( region.y * UInt( bytesPerRow ) ) + ( region.x * UInt( bytesPerPixel ) )
            
        pixelPointer.advancedBy( Int( pixelOffset ) )
            
        let nextRowOffset : Int = Int( self.width - region.width )
        
        for _ : Int in 0 ..< Int( region.height )
        {
            for _ : Int in 0 ..< Int( region.width )
            {
                let pixel = pixelSource()!
                
                pixelPointer.memory = UInt8( pixel.blue * 255.0 )
                
                pixelPointer.advancedBy( 1 )
                pixelPointer.memory = UInt8( pixel.green * 255.0 )
                
                pixelPointer.advancedBy( 1 )
                pixelPointer.memory = UInt8( pixel.red * 255.0 )
            }
            
            pixelPointer.advancedBy( nextRowOffset - 1 )
        }
        
        CVPixelBufferUnlockBaseAddress( self,0 )
    }
    
    var width : UInt
    {
        get { return UInt( CVPixelBufferGetWidth( self ) ) }
    }
    
    var height : UInt
    {
        get { return UInt( CVPixelBufferGetHeight( self ) ) }
    }
}

/*
extension CVPixelBuffer
{
    func cropScaleArea(x: UInt, y: UInt, height: UInt, width: UInt, outputWidth: UInt, outputHeight: UInt) -> CVPixelBuffer
    {
        assert( CVPixelBufferGetPixelFormatType(self) == kCVPixelFormatType_32BGRA, "This function supports only 32BGRA formatted buffers")

        CVPixelBufferLockBaseAddress(self,0)

        let
            planeCount : UInt    = 4,
            baseAddress          = CVPixelBufferGetBaseAddress(self),
            bytesPerRowIn        = CVPixelBufferGetBytesPerRow(self),
            startPos             = Int( (y*UInt(bytesPerRowIn)) + (UInt(planeCount)*x) ),
            bytesPerRowOut       = planeCount*outputWidth,
            inBuff               = vImage_Buffer( data: baseAddress.advancedBy( startPos ), height:height, width:width, rowBytes:bytesPerRowIn ),
            outBuff              = vImage_Buffer( data: malloc( Int( planeCount * outputWidth * outputHeight ) ), height: outputHeight, width: outputWidth, rowBytes: Int( bytesPerRowOut ) ),
            flags : vImage_Flags = 0,
            imageInBufferPtr     = UnsafeMutablePointer<vImage_Buffer>(inBuff.data),
            imageOutBufferPtr    = UnsafeMutablePointer<vImage_Buffer>(outBuff.data),
            err                  = vImageScale_ARGB8888(imageInBufferPtr, imageOutBufferPtr, nil, flags)

        let outImage : CVPixelBuffer
        
        if (err != kvImageNoError)
        {
            print(" error %ld", err.description)
            
            outImage = self
        }
        else
        {
            let
            allocator             : CFAllocator?                         = kCFAllocatorDefault,
            width                 : Int                                  = Int( outputWidth ),
            height                : Int                                  = Int( outputHeight ),
            pixelFormatType       : OSType                               = kCVPixelFormatType_32BGRA,
            baseAddress           : UnsafeMutablePointer<Void>           = outBuff.data,
            bytesPerRow           : Int                                  = Int( bytesPerRowOut ),
            releaseCallback       : CVPixelBufferReleaseBytesCallback?   = nil,
            releaseRefCon         : UnsafeMutablePointer<Void>           = nil,
            pixelBufferAttributes : CFDictionary?                        = nil,
            pixelBufferOut        : UnsafeMutablePointer<CVPixelBuffer?> = UnsafeMutablePointer<CVPixelBuffer?>()

            let pix2 = UnsafeMutablePointer<CVPixelBuffer?>()

            let testResult = CVPixelBufferCreate(kCFAllocatorDefault, 640, 480, kCVPixelFormatType_32BGRA, nil, pix2)

            print(testResult)

            let result : CVReturn = CVPixelBufferCreateWithBytes(
                allocator,
                width,
                height,
                pixelFormatType,
                baseAddress,
                bytesPerRow,
                releaseCallback,
                releaseRefCon,
                pixelBufferAttributes,
                pixelBufferOut
            )

            CVPixelBufferUnlockBaseAddress(self,0)

            if result == kCVReturnSuccess
            {
                let pixelBufferMemory : CVPixelBuffer? = pixelBufferOut.memory

                print(pixelBufferMemory)

                outImage = pixelBufferMemory!
            }
            else
            {
                outImage = self
            }
        }
        
        return outImage
    }
}
*/