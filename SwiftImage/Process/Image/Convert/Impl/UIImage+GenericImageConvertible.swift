//
//  UIImage+GenericImageConvertible.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 02/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage : GenericImageConvertible
{
    public func toGenericImage() -> GenericImage<PixelType>
    {
        let fillPixel = RGBPixel(0,0,0)
        
        let genericImage : GenericImage<PixelType> = GenericImage<PixelType>(width: self.width, height: self.height, fill: fillPixel )
        
        let region = ImageRegion( image: self )
        
        let regionPixelSource : PixelSource = readRegion( region )
        
        genericImage.writeRegion( region, pixelSource: regionPixelSource )
        
        return genericImage
    }
}