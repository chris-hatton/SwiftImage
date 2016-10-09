//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGImage
{
    public func convert() -> UIImage
    {
        return UIImage(cgImage: self)
    }
    
    public func convert() -> GenericImage<RGBPixel>
    {
        let fillPixel = RGBPixel(0,0,0)
        
        let image = GenericImage<RGBPixel>(width: self.width, height: self.height, fill: fillPixel )
        
        let region = ImageRegion( image: self )
        
        let regionPixelSource : PixelSource = self.read( region: region )
        
        image.write( region: region, pixelSource: regionPixelSource )
        
        return image
    }
    
    public func convert() -> CVPixelBuffer
    {
        let
        width  : Int = Int( self.width  ),
        height : Int = Int( self.height )
        
        let frameSize : CGSize = CGSize( width: width, height: height )
        
        let options : [ String : Bool ] = [
            kCVPixelBufferCGImageCompatibilityKey         as String : false,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String : false
        ]
        
        var bufferRef : CVPixelBuffer? = nil
        
        let status : CVReturn = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(frameSize.width),
            Int(frameSize.height),
            kCVPixelFormatType_32RGBA,
            options as CFDictionary,
            &bufferRef
        )
        
        assert(status == kCVReturnSuccess)
        
        guard let buffer = ( status == kCVReturnSuccess ) ? ( bufferRef! ) : (nil as CVPixelBuffer?) else
        {
            fatalError()
        }
        
        let pixelData : UnsafeMutableRawPointer = CVPixelBufferGetBaseAddress( bufferRef! )!;
        
        let rgbColorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context : CGContext = CGContext(
            data: pixelData,
            width: Int( frameSize.width ),
            height: Int( frameSize.height ),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow( buffer ),
            space: rgbColorSpace,
            bitmapInfo: UInt32(0) //TODO: Replace with kCGImageAlphaNoneSkipLast
            )!
        
        let rect : CGRect = CGRect(x: 0, y: 0, width: CGFloat( width ), height: CGFloat( height ) )
        
        context.draw( self, in: rect)
        
        CVPixelBufferUnlockBaseAddress( buffer, CVPixelBufferLockFlags(rawValue: CVOptionFlags(0)) )
        
        return buffer
    }
    
    public func convert() -> CIImage
    {
        return CIImage(cgImage: self)
    }
}
