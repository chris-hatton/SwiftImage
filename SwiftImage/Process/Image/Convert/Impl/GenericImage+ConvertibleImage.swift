//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreVideo

private struct Info
{
    let byteCount   : Int
    let rgbaDataPtr : UnsafeRawPointer
}

extension GenericImage : ConvertibleImage
{
    public func convert() -> CGImage
    {
        return pixels.withUnsafeMutableBufferPointer
        {
            pixelBufferPtr in
            
            let byteCount = (width * height * 4)
            
            return pixelBufferPtr.baseAddress!.withMemoryRebound(to: UInt8.self, capacity: byteCount )
            {
                pixelBytePtr in
                
                let bitsPerComponent : Int = 8
                let bytesPerPixel    : Int = 4
                let bitsPerPixel     : Int = (bytesPerPixel * 8)
                let bytesPerRow      : Int = (bytesPerPixel * width)
                let byteCount        : Int = (bytesPerRow * height)
                
                let copiedPixelBytes = UnsafeMutablePointer<UInt8>.allocate(capacity: byteCount)
                memcpy(copiedPixelBytes, pixelBytePtr, byteCount)
                
                let infoPtr = UnsafeMutablePointer<Info>.allocate(capacity: 1)
                infoPtr.pointee = Info(byteCount: byteCount, rgbaDataPtr: copiedPixelBytes)
                
                var cgDataProviderDirectCallbacks : CGDataProviderDirectCallbacks
                
                do // Set up direct data-provider callbacks
                {
                    let version : UInt32 = UInt32(0)
                    
                    let releaseBytePointer : CGDataProviderReleaseBytePointerCallback? =
                    {
                        (infoRawPtr:UnsafeMutableRawPointer?, dataRawPtr:UnsafeRawPointer) in
                        
                        guard let infoPtr = infoRawPtr?.assumingMemoryBound(to: Info.self) else { assertionFailure(); return }
                        let dataPtr = UnsafeMutablePointer( mutating: dataRawPtr.assumingMemoryBound(to: UInt8.self) )
                        
                        let byteCount = infoPtr.pointee.byteCount
                        dataPtr.deallocate(capacity: byteCount)
                    }
                    
                    let getBytesAtPosition : CGDataProviderGetBytesAtPositionCallback? = nil
                    
                    let releaseInfo : CGDataProviderReleaseInfoCallback? =
                    {
                        (infoPtr: UnsafeMutableRawPointer?) -> Swift.Void in
                        
                        infoPtr!.assumingMemoryBound(to: Info.self).deallocate(capacity: 1)
                    }
                    
                    let getBytePointer : CGDataProviderGetBytePointerCallback? =
                    {
                        (infoPtr: UnsafeMutableRawPointer?) -> UnsafeRawPointer? in
                        
                        let info = infoPtr!.assumingMemoryBound(to: Info.self).pointee
                        return UnsafeRawPointer(info.rgbaDataPtr)
                    }
                    
                    cgDataProviderDirectCallbacks = CGDataProviderDirectCallbacks(
                        version            : version,
                        getBytePointer     : getBytePointer,
                        releaseBytePointer : releaseBytePointer,
                        getBytesAtPosition : getBytesAtPosition,
                        releaseInfo        : releaseInfo
                    )
                }
                
                let colorSpace        : CGColorSpace           = CGColorSpaceCreateDeviceRGB()
                let bitmapInfo        : CGBitmapInfo           = CGBitmapInfo.init(rawValue: CGImageAlphaInfo.last.rawValue)
                let intent            : CGColorRenderingIntent = CGColorRenderingIntent.defaultIntent
                let shouldInterpolate : Bool                   = false
                
                let dataProvider : CGDataProvider = CGDataProvider(
                    directInfo : infoPtr,
                    size       : off_t(byteCount),
                    callbacks  : &cgDataProviderDirectCallbacks
                    )!
                
                return CGImage(
                    width             : width,
                    height            : height,
                    bitsPerComponent  : bitsPerComponent,
                    bitsPerPixel      : bitsPerPixel,
                    bytesPerRow       : bytesPerRow,
                    space             : colorSpace,
                    bitmapInfo        : bitmapInfo,
                    provider          : dataProvider,
                    decode            : nil,
                    shouldInterpolate : shouldInterpolate,
                    intent            : intent
                )!
            }
        }
    }
    
    public func convert() -> UIImage
    {
        let cgImage : CGImage = self.convert()
        return UIImage(cgImage: cgImage)
    }
    
    public func convert() -> CVPixelBuffer
    {
        let cgImage : CGImage = self.convert()
        return cgImage.convert()
    }
    
    public func convert() -> CIImage
    {
        let cgImage : CGImage = self.convert()
        return cgImage.convert()
    }
}
