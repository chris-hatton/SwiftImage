//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

extension CGImage : GenericImageConvertible
{
    func toGenericImage() -> GenericImage<PixelType>
    {
        let fillPixel = RGBPixel(0,0,0)
        
        let genericImage : GenericImage<PixelType> = GenericImage<PixelType>(width: self.width, height: self.height, fill: fillPixel )
        
        let region = ImageRegion( image: self )
        
        let regionPixelSource : PixelSource = self.readRegion( region )
        
        genericImage.writeRegion( region, pixelSource: regionPixelSource )
        
        return genericImage
    }
}