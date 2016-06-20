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

        var bufferRef : CVPixelBuffer? = nil

        let status : CVReturn = CVPixelBufferCreate(
            kCFAllocatorDefault,
            Int(frameSize.width),
            Int(frameSize.height),
            kCVPixelFormatType_32ARGB,
            options as CFDictionary,
            &bufferRef
        )

        assert(status == kCVReturnSuccess)

        let buffer : CVPixelBuffer? = ( status == kCVReturnSuccess ) ? ( bufferRef! ) : nil

        if buffer != nil
        {
            let pixelData : UnsafeMutablePointer<Void> = CVPixelBufferGetBaseAddress( bufferRef! )!;

            let rgbColorSpace : CGColorSpace = CGColorSpaceCreateDeviceRGB()

            let context : CGContext = CGContext(
                data: pixelData,
                width: Int( frameSize.width ),
                height: Int( frameSize.height ),
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow( buffer! ),
                space: rgbColorSpace,
                bitmapInfo: UInt32(0) //TODO: Replace with kCGImageAlphaNoneSkipLast
            )!

            let rect : CGRect = CGRect(x: 0, y: 0, width: CGFloat( width ), height: CGFloat( height ) )

            context.draw(in: rect,
                image: self
            )

            CVPixelBufferUnlockBaseAddress( buffer!, 0 )
        }

        return buffer!
    }
}
