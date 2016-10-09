//
//  UIImage+GenericImageConvertible.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 02/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage : ConvertibleImage
{
    @nonobjc public func convert() -> GenericImage<PixelType>
    {
        let fillPixel = RGBPixel(0,0,0)
        
        print("Width: \(self.width), Height: \(self.height)")
        
        let genericImage : GenericImage<PixelType> = GenericImage<PixelType>(width: self.width, height: self.height, fill: fillPixel )
        
        let region = ImageRegion( image: self )
        
        let regionPixelSource : PixelSource = read( region: region )
        
        genericImage.write( region: region, pixelSource: regionPixelSource )
        
        return genericImage
    }
    
    @nonobjc public func convert() -> CGImage
    {
        return self.cgImage!
    }
    
    @nonobjc public func convert() -> CIImage
    {
        return self.ciImage!
    }
    
    @nonobjc public func convert() -> CVPixelBuffer
    {
        return self.cgImage!.convert()
    }
}
