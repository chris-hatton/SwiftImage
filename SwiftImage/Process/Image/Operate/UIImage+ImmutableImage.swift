//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage : ImmutableImage
{
    typealias PixelType   = RGBPixel
    typealias PixelSource = ()->PixelType?
    
    func readRegion( region: ImageRegion ) -> PixelSource
    {
        let pixelPtr = UnsafeMutablePointer<UInt8>()
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let context : CGContext = CGBitmapContextCreate(
            pixelPtr,
            Int( region.width  ), // Width
            Int( region.height ), // Height
            8,  // Bits per component
            3,  // Bytes per row
            rgbColorSpace,
            CGImageAlphaInfo.NoneSkipLast.rawValue
        )!
        
        UIGraphicsPushContext(context)
        
        self.drawAtPoint( CGPointMake( -CGFloat( region.x ), -CGFloat( region.y ) ) )
        
        UIGraphicsPopContext()
        
        var
            pixelIndex : Int = 0,
            pixelCount : Int = Int( region.width * region.height )
        
        let pixelSource : PixelSource =
        {
            let pixel : PixelType?
            
            if pixelIndex < pixelCount
            {
                let r : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                let g : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                let b : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                
                pixel = RGBPixel(r,g,b)
            }
            else
            {
                pixel = nil
            }
            
            ++pixelCount
            
            return pixel
        }
        
        return pixelSource
    }

    var width : UInt
    {
        get { return self.width }
    }
    
    var height : UInt
    {
        get { return self.height }
    }
}