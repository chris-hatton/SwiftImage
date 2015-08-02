//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage

extension CIImage : ImmutableImage
{
    public typealias PixelType   = RGBPixel
    public typealias PixelSource = ()->PixelType?
    
    public func readRegion( region: ImageRegion ) -> PixelSource
    {
        let pixelSource : PixelSource =
        {
                return nil
        }
        
        return pixelSource
    }
    
    public var width : UInt
    {
        get { return UInt( self.extent.width ) }
    }
    
    public var height : UInt
    {
        get { return UInt( self.extent.height ) }
    }
}