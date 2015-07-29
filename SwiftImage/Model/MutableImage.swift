//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

protocol MutableImage : ImmutableImage
{
    typealias PixelType : Pixel
    typealias PixelSource = ()->PixelType?
    
    func writeRegion( region: ImageRegion, pixelSource: PixelSource)
}
