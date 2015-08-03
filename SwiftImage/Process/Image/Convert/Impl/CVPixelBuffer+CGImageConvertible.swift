//
// Created by Christopher Hatton on 03/08/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage
import CoreVideo

extension CVPixelBuffer : CGImageConvertible
{
    public func toCGImage() -> CGImage
    {
        let ciImage: CIImage = CIImage( CVPixelBuffer: self )

        let temporaryContext : CIContext = CIContext()

        let rect : CGRect = CGRectMake( 0, 0, CGFloat( self.width ), CGFloat( self.height ) )

        let cgImage : CGImage = temporaryContext.createCGImage( ciImage, fromRect: rect )

        return cgImage
    }
}