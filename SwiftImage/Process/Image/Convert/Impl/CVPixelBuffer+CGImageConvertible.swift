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
        let ciImage: CIImage = CIImage( cvPixelBuffer: self )

        let temporaryContext : CIContext = CIContext()

        let rect : CGRect = CGRect( x: 0, y: 0, width: CGFloat( self.width ), height: CGFloat( self.height ) )

        let cgImage : CGImage = temporaryContext.createCGImage( ciImage, from: rect )!

        return cgImage
    }
}
