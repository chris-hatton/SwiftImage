//
//  Convert.swift
//  SwiftCrashTest
//
//  Created by Chris Hatton on 8/09/2015.
//  Copyright © 2015 ChrisHatton. All rights reserved.
//

import Foundation
import CoreGraphics

func convert<TP>(_ genImage : GenericImage<TP>?) -> CGImage
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
                (in1 : UnsafeMutablePointer<Swift.Void>?) -> UnsafePointer<Swift.Void>? in
            
            let dataPtr = UnsafePointer<Void>(in1)
            
            return dataPtr!
            
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
        
        let dataPtr : UnsafeMutablePointer<Void> = UnsafeMutablePointer<Void>(nil)!
        
        dataProvider = CGDataProvider(
            directInfo: dataPtr,
            size: size,
            callbacks: &cgDataProviderDirectCallbacks
            )!
    }
    
    let cgImage : CGImage
    
    do // Create image
    {
        let
            colorSpace        : CGColorSpace           = CGColorSpaceCreateDeviceRGB(),
            bitmapInfo        : CGBitmapInfo           = CGBitmapInfo.alphaInfoMask,
            intent            : CGColorRenderingIntent = CGColorRenderingIntent.defaultIntent,
            shouldInterpolate : Bool                   = false
            
        var decode : CGFloat = 0.0
        
        cgImage = CGImage(
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bitsPerPixel: bitsPerPixel,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            provider: dataProvider,
            decode: &decode,
            shouldInterpolate: shouldInterpolate,
            intent: intent
            )!
    }
    
    return cgImage
    
}
