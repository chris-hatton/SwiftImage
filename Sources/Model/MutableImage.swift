//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

public protocol MutableImage : Image
{
    func write(region: ImageRegion, pixelColorSource: Self.PixelColorSource)
}

extension MutableImage
{
    public func set( x: Int, y: Int, color: Self.PixelColor )
    {
        self.write(
            region: ImageRegion.singlePixelRegion(x: x, y: y),
            pixelColorSource: { () -> Self.PixelColor? in return color } as! Self.PixelColorSource
        )
    }
}
