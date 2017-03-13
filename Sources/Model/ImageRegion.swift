//
//  ImageRegion.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 25/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public struct ImageRegion
{
    public let
        x     : Int,
        y     : Int,
        width : Int,
        height: Int
    
    public init( x: Int = 0, y: Int = 0, width: Int, height: Int )
    {
        self.x      = x
        self.y      = y
        self.width  = width
        self.height = height
    }
    
    public init<ImageType:Image>( image: ImageType )
    {
        self.x      = 0
        self.y      = 0
        self.width  = image.width
        self.height = image.height
    }
    
    public var pixelCount : Int { return width * height }
    
    public static func singlePixelRegion( x: Int, y: Int ) -> ImageRegion
    {
        return ImageRegion( x: x, y: y, width: 1, height: 1 )
    }
}
