//
//  GenericImage.swift
//  SwiftVision
//
//  Created by Christopher Hatton on 20/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public class GenericImage<TP : Pixel> : MutableImage
{
    public typealias PixelType = TP
    public typealias ImageType = GenericImage
    public typealias PixelSource = ()->TP?
    
    var pixels : [PixelType]
    
    public var
        width  : UInt,
        height : UInt
    
    // TODO: Create another constructor which uses a PixelSource for the initial fill
    
    public init(width: UInt, height: UInt, fill: PixelType)
    {
        pixels = [PixelType](count: Int( width * height ), repeatedValue: fill)
        
        self.width  = width
        self.height = height
    }
    
    public func readRegion( region: ImageRegion ) -> PixelSource
    {
        var i : Int = Int( ( region.y * self.width ) + region.x )
        
        let widthOutsideRegion = Int( self.width - region.width )
        
        let nextLine = { i += widthOutsideRegion }
        
        let nextPixel = { return self.pixels[ i++ ] }
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
    }

    public func writeRegion( region: ImageRegion, pixelSource: PixelSource )
    {
        for y : UInt in region.y ..< region.height
        {
            for x : UInt in region.x ..< region.width
            {
                let pixel : PixelType = pixelSource()!
                
                self.pixels[ Int( ( y * width ) + x ) ] = pixel
            }
        }
    }
}