//
//  Pixels.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation
import UIKit

public protocol Pixel {}

public struct HSVPixel : Pixel
{
    var
        hue        : Double,
        saturation : Double,
        value      : Double

    init(_ hue: Double, _ saturation: Double, _ value: Double)
    {
        self.hue        = hue
        self.saturation = saturation
        self.value      = value
    }
}

public struct RGBPixel : Pixel
{
    var
        red   : Double,
        green : Double,
        blue  : Double

    init(_ red: Double, _ green: Double, _ blue: Double)
    {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    
    init(_ color: UIColor)
    {
        var red     : CGFloat = 0.0
        var green   : CGFloat = 0.0
        var blue    : CGFloat = 0.0
        var alpha   : CGFloat = 0.0
        
        color.getRed( &red, green: &green, blue: &blue, alpha: &alpha)
        
        self.red   = Double( red )
        self.green = Double( green )
        self.blue  = Double( blue )
    }
}
