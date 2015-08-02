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
        x     : UInt,
        y     : UInt,
        width : UInt,
        height: UInt
    
    init( x: UInt = 0, y: UInt = 0, width: UInt, height: UInt )
    {
        self.x      = x
        self.y      = y
        self.width  = width
        self.height = height
    }
    
    init<ImageType:ImmutableImage>( image: ImageType )
    {
        self.x      = 0
        self.y      = 0
        self.width  = image.width
        self.height = image.height
    }
    
    static func singlePixelRegion( x: UInt, y: UInt ) -> ImageRegion
    {
        return ImageRegion( x: x, y: y, width: UInt(1), height: UInt(1) )
    }
}