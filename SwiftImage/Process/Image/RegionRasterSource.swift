//
//  RasterScan.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 28/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

func regionRasterSource<PixelType:Pixel>( region: ImageRegion, nextPixel: ()->PixelType, nextLine: ()->Void, end: (()->Void)? = nil) -> ()->PixelType?
{
    var
        x : UInt = region.x,
        y : UInt = region.y
    
    var ended = false
    
    let regionRasterSource : ()->PixelType? =
    {
        let pixel : PixelType?
        
        if y == region.height
        {
            if !ended
            {
                ended = true
                end?()
            }
            
            pixel = nil
        }
        else
        {
            if x == region.width
            {
                nextLine()
                
                ++y
                x = 0
            }
            
            pixel = nextPixel()
            
            ++x
        }
        
        return pixel
    }
    
    return regionRasterSource
}
