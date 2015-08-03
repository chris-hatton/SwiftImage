//
// Created by Christopher Hatton on 03/08/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreVideo

extension CGImage : CVPixelBufferConvertible
{
    public func toCVPixelBuffer() -> CVPixelBuffer
    {
        let
            width  : Int = Int( self.width  ),
            height : Int = Int( self.height )

        let frameSize : CGSize = CGSize( width: width, height: height )

        let options : [ String : Bool ] = [
            kCVPixelBufferCGImageCompatibilityKey         as String : false,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String : false
        ]

        let bufferRef : UnsafeMutablePointer<CVPixelBuffer?> = UnsafeMutablePointer<CVPixelBuffer?>()

        let status : CVReturn = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(frameSize.width),
            Int(frameSize.height),
            kCVPixelFormatType_32ARGB,
            options as CFDictionary,
            bufferRef
        )

        assert(status == kCVReturnSuccess)

        let buffer : CVPixelBuffer? = ( status == kCVReturnSuccess ) ? ( bufferRef.memory ) : nil

        if buffer != nil
        {
            let pixelData : UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddress( bufferRef.memory! );

            let rgbColorSpace : CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!

            let context : CGContext = CGBitmapContextCreate(
                pixelData,
                Int( frameSize.width ),
                Int( frameSize.height ),
                8,
                CVPixelBufferGetBytesPerRow( buffer! ),
                rgbColorSpace,
                UInt32(0) //TODO: Replace with kCGImageAlphaNoneSkipLast
            )!

            let rect : CGRect = CGRectMake(0, 0, CGFloat( width ), CGFloat( height ) )

            CGContextDrawImage(
                context,
                rect,
                self
            )

            CVPixelBufferUnlockBaseAddress( buffer!, 0 )
        }

        return buffer!
    }
}