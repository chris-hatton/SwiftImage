//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage

extension CIImage : ImmutableImage
{
    typealias PixelType   = RGBPixel
    typealias PixelSource = ()->PixelType?
    
    func readRegion( region: ImageRegion ) -> PixelSource
    {
        let pixelSource : PixelSource =
        {
                return nil
        }
        
        return pixelSource
    }
    
    var width : UInt
    {
        get { return UInt( self.extent.width ) }
    }
    
    var height : UInt
    {
        get { return UInt( self.extent.height ) }
    }
}