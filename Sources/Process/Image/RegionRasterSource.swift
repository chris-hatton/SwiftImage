//
//  RasterScan.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 28/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public func regionRasterSource<PixelColor:Color>(
        _ region:    ImageRegion,
        nextPixel: @escaping ()->PixelColor,
        nextLine:  @escaping ()->Void,
        end:       (()->Void)? = nil) -> ()->PixelColor?
{
    var
        x : Int = region.x,
        y : Int = region.y
    
    var ended = false
    
    let regionRasterSource : ()->PixelColor? =
    {
        let pixel : PixelColor?
        
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
