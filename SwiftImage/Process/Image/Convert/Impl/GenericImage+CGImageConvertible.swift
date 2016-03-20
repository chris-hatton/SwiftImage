//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

// Swift cannot compile this yet, the Swift compiler crashes.
// Bug files on Apple's Radar.
// Until fixed we use an Objective-C implementation.

import Foundation
import CoreGraphics

extension GenericImage : CGImageConvertible
{
    public func toCGImage() -> CGImage
    {
        return GenericToCGImageConverter().convert( self )
    }
}

private class GenericToCGImageConverter
{
    func convert<T>(genericImage: GenericImage<T>) -> CGImage
    {
        let cgImage : CGImage = convert(self)
        
        return cgImage
        
        /*
        let
            width            : Int = 10,
            height           : Int = 10,
            bitsPerComponent : Int = 8,
            bytesPerPixel    : Int = 4,
            bitsPerPixel     : Int = (bytesPerPixel * 8),
            bytesPerRow      : Int = (bytesPerPixel * width)
            
        var cgDataProviderDirectCallbacks : CGDataProviderDirectCallbacks
        
        func getByte(info: UnsafeMutablePointer<Void>) -> UnsafePointer<Void>
        {
            return UnsafePointer<Void>(info)
        }
        
        do // Set up direct data-provider callbacks
        {
            let version : UInt32 = UInt32(0)
            
            let releaseBytePointer : CGDataProviderReleaseBytePointerCallback? = nil
            let getBytesAtPosition : CGDataProviderGetBytesAtPositionCallback? = nil
            let releaseInfo        : CGDataProviderReleaseInfoCallback?        = nil
            let getBytePointer     : CGDataProviderGetBytePointerCallback?     = getByte
            
            cgDataProviderDirectCallbacks = CGDataProviderDirectCallbacks(
                version:            version,
                getBytePointer:     getBytePointer,
                releaseBytePointer: releaseBytePointer,
                getBytesAtPosition: getBytesAtPosition,
                releaseInfo:        releaseInfo
            )
        }
        
        let dataProvider : CGDataProvider
        
        do // Set up direct data-provider
        {
            let size : off_t = off_t( bytesPerRow * height )
            
            dataProvider = CGDataProviderCreateDirect(
                &genericImage.pixels,
                size,
                &cgDataProviderDirectCallbacks
                )!
        }
        
        let cgImage : CGImage
        
        do // Create image
        {
            let
            colorSpace        : CGColorSpace           = CGColorSpaceCreateDeviceRGB()!,
            bitmapInfo        : CGBitmapInfo           = CGBitmapInfo.AlphaInfoMask,
            decode            : UnsafePointer<CGFloat> = UnsafePointer<CGFloat>(),
            intent            : CGColorRenderingIntent = CGColorRenderingIntent.RenderingIntentDefault,
            shouldInterpolate : Bool                   = false
            
            cgImage = CGImageCreate(
                width,
                height,
                bitsPerComponent,
                bitsPerPixel,
                bytesPerRow,
                colorSpace,
                bitmapInfo,
                dataProvider,
                decode,
                shouldInterpolate,
                intent
                )!
        }
        
        return cgImage
*/
    }
}
