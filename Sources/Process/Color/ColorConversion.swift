//
//  ColorConversion.swift
//  ResistAR
//
//  Created by Christopher Hatton on 06/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

public extension RGBColor
{
    init( pixel: HSVColor)
    {
        self = HSVtoRGB( pixel )
    }
}

public func HSVtoRGB(_ hsv: HSVColor) -> RGBColor
{
    var
        r : Double,
        g : Double,
        b : Double
    
    let
        h = UInt(hsv.hue * 6),
        f = hsv.hue * 6 - Double(h),
        p = hsv.value * (1 - hsv.saturation),
        q = hsv.value * (1 - f * hsv.saturation),
        t = hsv.value * (1 - (1 - f) * hsv.saturation)
    
    switch(h)
    {
        case 0:
            r = hsv.value;
            g = t;
            b = p;
        break
        case 1:
            r = q;
            g = hsv.value;
            b = p;
        break
        case 2:
            r = p;
            g = hsv.value;
            b = t;
        break
        case 3:
            r = p;
            g = q;
            b = hsv.value;
        break
        case 4:
            r = t;
            g = p;
            b = hsv.value;
        break
        case 5:
            r = hsv.value;
            g = p;
            b = q;
        break
        default:
            r = 0
            g = 0
            b = 0
        break
    }
    
    return RGBColor(r,g,b)
}

extension HSVColor
{
    init( pixel: RGBColor)
    {
        self = RGBtoHSV( pixel )
    }
}

func RGBtoHSV(_ rgb: RGBColor) -> HSVColor
{
    let
        r     : Double = rgb.red(),
        g     : Double = rgb.green(),
        b     : Double = rgb.blue()
    
    var
        min   : Double,
        max   : Double,
        delta : Double,

        h     : Double,
        s     : Double,
        v     : Double
    
    min = r   < g ? r   : g
    min = min < b ? min : b
    
    max = r   > g ? r   : g
    max = max > b ? max : b
    
    v = max
    delta = max - min

    if( max > 0.0 )
    {
        s = delta / max
    }
    else
    {
        s = 0.0
        h = Double.nan
    }
    
    if( r == max )
    {
        h = ( g - b ) / delta // between yellow & magenta
    }
    else if( g >= max )
    {
        h = 2.0 + ( b - r ) / delta // between cyan & yellow
    }
    else
    {
        h = 4.0 + ( r - g ) / delta // between magenta & cyan
    }
    
    h *= 60.0 // degrees
    
    if( h < 0.0 )
    {
        h += 360.0
    }
    
    return HSVColor(h,s,v)
}
