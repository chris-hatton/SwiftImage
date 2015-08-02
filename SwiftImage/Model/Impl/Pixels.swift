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
        let
            redPointer   = UnsafeMutablePointer<CGFloat>(),
            greenPointer = UnsafeMutablePointer<CGFloat>(),
            bluePointer  = UnsafeMutablePointer<CGFloat>(),
            alphaPointer = UnsafeMutablePointer<CGFloat>()
        
        color.getRed(redPointer, green: greenPointer, blue: bluePointer, alpha: alphaPointer)
        
        self.red   = Double( redPointer.memory   )
        self.green = Double( greenPointer.memory )
        self.blue  = Double( bluePointer.memory  )
    }
}
