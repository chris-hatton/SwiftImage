//
// Created by Christopher Hatton on 03/08/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage
import CoreVideo

extension CVPixelBuffer : CGImageConvertible
{
    func toCGImage()
    {
        let ciImage: CIImage = CIImage(CVPixelBuffer: buffer)

        let temporaryContext : CIContext = CIContext()

        let rect : CGRect = CGRectMake( 0, 0, CGFloat( CVPixelBufferGetWidth( buffer ) ), CGFloat( CVPixelBufferGetHeight( buffer ) ) )

        let cgImage : CGImage = temporaryContext.createCGImage( ciImage, fromRect: rect )

        return cgImage
    }
}