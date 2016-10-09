//
//  GenericImage.swift
//  SwiftVision
//
//  Created by Christopher Hatton on 20/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public final class GenericImage<TP : Pixel> : MutableImage
{
    public typealias PixelType   = TP
    public typealias ImageType   = GenericImage
    public typealias PixelSource = ()->TP?
    
    var pixels : ContiguousArray<PixelType>
    
    public var
        width  : Int,
        height : Int
    
    // TODO: Create another constructor which uses a PixelSource for the initial fill
    
    public init(width: Int, height: Int, fill: PixelType)
    {
        pixels = ContiguousArray<PixelType>(repeating: fill, count: Int( width * height ))
        
        self.width  = width
        self.height = height
    }
    
    public func read( region: ImageRegion ) -> PixelSource
    {
        var i : Int = Int( ( region.y * self.width ) + region.x )
        
        let widthOutsideRegion = Int( self.width - region.width )
        
        let nextLine = { i += widthOutsideRegion }
        
        let nextPixel = { return self.pixels[ i ] }
        
        i += 1
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
    }

    public func write( region: ImageRegion, pixelSource: @escaping PixelSource )
    {
        for y : Int in region.y ..< region.height
        {
            for x : Int in region.x ..< region.width
            {
                guard let pixel : PixelType = pixelSource() else { fatalError() }
                
                self.pixels[ Int( ( y * width ) + x ) ] = pixel
            }
        }
    }
}
