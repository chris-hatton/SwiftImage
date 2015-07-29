//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension GenericImage : CGImageConvertible
{
    func toCGImage() -> CGImage
    {
        var callbacks : CGDataProviderDirectCallbacks = CGDataProviderDirectCallbacks()
        
        func getBytes(pointer: UnsafeMutablePointer<Void>) -> UnsafePointer<Void>
        {
            return UnsafePointer<Void>()
        }
        
        let getBytePointerCallback : CGDataProviderGetBytePointerCallback? = getBytes
        
        let
            width            : Int = 10,
            height           : Int = 10,
            bitsPerComponent : Int = 8,
            bytesPerPixel    : Int = 4,
            bitsPerPixel     : Int = (bytesPerPixel * 8),
            bytesPerRow      : Int = (bytesPerPixel * width)
        
        let colorSpace : CGColorSpace           = CGColorSpaceCreateDeviceRGB()!
        let bitmapInfo : CGBitmapInfo           = CGBitmapInfo.AlphaInfoMask
        let decode     : UnsafePointer<CGFloat> = UnsafePointer<CGFloat>()
        let intent     : CGColorRenderingIntent = CGColorRenderingIntent.RenderingIntentDefault
        
        let info : UnsafeMutablePointer<Void> = UnsafeMutablePointer<Void>()
        let size : off_t = off_t( bytesPerRow * height )
        let callbacksPointer : UnsafePointer<CGDataProviderDirectCallbacks> = UnsafePointer<CGDataProviderDirectCallbacks>()
        //callbacksPointercallbacksPointer.memory = callbacks
        
        let dataProvider : CGDataProvider = CGDataProviderCreateDirect(
            info,
            size,
            callbacksPointer
        )!
        
        let shouldInterpolate : Bool = false
        
        let cgImage : CGImage = CGImageCreate(
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
        
        return cgImage
    }
}