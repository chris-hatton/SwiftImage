//
//  HSVPixel.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

public struct HSVPixel : Pixel
{
    public var
        hue        : Double,
        saturation : Double,
        value      : Double
        
    public init(_ hue: Double, _ saturation: Double, _ value: Double)
    {
        self.hue        = hue
        self.saturation = saturation
        self.value      = value
    }
}
