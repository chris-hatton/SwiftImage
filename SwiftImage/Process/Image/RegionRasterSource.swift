//
//  RasterScan.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 28/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

func regionRasterSource<PixelType:Pixel>(
        _ region:    ImageRegion,
        nextPixel: ()->PixelType,
        nextLine:  ()->Void,
        end:       (()->Void)? = nil) -> ()->PixelType?
{
    var
        x : Int = region.x,
        y : Int = region.y
    
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
                
                y += 1
                x = 0
            }
            
            pixel = nextPixel()
            
            x += 1
        }
        
        return pixel
    }
    
    return regionRasterSource
}
