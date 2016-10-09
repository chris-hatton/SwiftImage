//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage

extension CIImage : Image
{
    public typealias PixelType   = RGBPixel
    public typealias PixelSource = ()->PixelType?
    
    public func read( region: ImageRegion ) -> PixelSource
    {
        let pixelSource : PixelSource =
        {
                return nil
        }
        
        return pixelSource
    }
    
    public var width : Int
    {
        get { return Int( self.extent.width ) }
    }
    
    public var height : Int
    {
        get { return Int( self.extent.height ) }
    }
}
