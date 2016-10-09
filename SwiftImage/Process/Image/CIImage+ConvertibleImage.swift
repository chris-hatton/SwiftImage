//
//  CIImage+ConvertibleImage.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 05/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation
import CoreImage

extension CIImage : ConvertibleImage
{
    @nonobjc func convert() throws -> UIImage
    {
        return UIImage(ciImage: self)
    }
    
    @nonobjc func convert() throws -> CGImage
    {
        guard let cgImage = self.cgImage else { throw ConvertibleImageError.ConversionFailure }
        return cgImage
    }
    
    @nonobjc func convert() throws -> CVPixelBuffer
    {
        let cgImage = self.cgImage!
        return cgImage.convert()
    }
    
    @nonobjc func convert() throws -> GenericImage<RGBPixel>
    {
        let cgImage = self.cgImage!
        return cgImage.convert()
    }
}
