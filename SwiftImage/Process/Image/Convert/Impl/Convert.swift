//
//  Convert.swift
//  SwiftCrashTest
//
//  Created by Chris Hatton on 8/09/2015.
//  Copyright © 2015 ChrisHatton. All rights reserved.
//

import Foundation
import CoreGraphics

func convert<TP>(genImage : GenericImage<TP>?) -> CGImage
{
    let
        width            : Int = 10,
        height           : Int = 10,
        bitsPerComponent : Int = 8,
        bytesPerPixel    : Int = 4,
        bitsPerPixel     : Int = (bytesPerPixel * 8),
        bytesPerRow      : Int = (bytesPerPixel * width)
        
    var cgDataProviderDirectCallbacks : CGDataProviderDirectCallbacks
    
    do // Set up direct data-provider callbacks
    {
        let zero: UInt32 = UInt32(0)
        
        let releaseBytePointer : CGDataProviderReleaseBytePointerCallback? = nil
        let getBytePointer     : CGDataProviderGetBytePointerCallback? =
        {
            (in1) -> UnsafePointer<Void> in
            
            let dataPtr = UnsafePointer<Void>(in1)
            
            return dataPtr
        }
        
        let getBytesAtPosition : CGDataProviderGetBytesAtPositionCallback? = nil
        let releaseInfo        : CGDataProviderReleaseInfoCallback?        = nil
        
        cgDataProviderDirectCallbacks = CGDataProviderDirectCallbacks(
            version:            zero, // UInt32
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
        
        let dataPtr : UnsafeMutablePointer<Void> = UnsafeMutablePointer<Void>(nil)
        
        dataProvider = CGDataProviderCreateDirect(
            dataPtr,
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
    
}