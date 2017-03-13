//
//  GenericImage.swift
//  SwiftVision
//
//  Created by Christopher Hatton on 20/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public final class GenericImage<TP :Color> : MutableImage
{
    public typealias PixelColor       = TP
    public typealias ImageType        = GenericImage
    public typealias PixelColorSource = ()->TP?
    
    public var pixels : ContiguousArray<PixelColor>
    
    public var
        width  : Int,
        height : Int
    
    // TODO: Create another constructor which uses a PixelColorSource for the initial fill
    
    public init(width: Int, height: Int, fill: PixelColor)
    {
        pixels = ContiguousArray<PixelColor>(repeating: fill, count: Int( width * height ))
        
        self.width  = width
        self.height = height
    }
    
    public func read( region: ImageRegion ) -> PixelColorSource
    {
        var i : Int = Int( ( region.y * self.width ) + region.x )
        
        let widthOutsideRegion = Int( self.width - region.width )
        
        let nextLine = { i += widthOutsideRegion }
        
        let nextPixel = { return self.pixels[ i ] }
        
        i += 1
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
    }

    public func write( region: ImageRegion, pixelColorSource: @escaping PixelColorSource )
    {
        for y : Int in region.y ..< (region.y + region.height)
        {
            for x : Int in region.x ..< (region.x + region.width)
            {
                guard let pixel : PixelColor = pixelColorSource() else { fatalError() }
                
                self.pixels[ Int( ( y * width ) + x ) ] = pixel
            }
        }
    }
}
