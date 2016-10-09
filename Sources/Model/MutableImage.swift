//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

public protocol MutableImage : Image
{
    func write( region: ImageRegion, pixelSource: Self.PixelSource )
}
