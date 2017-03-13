//
//  Pixels.swift
//  ResistAR
//
//  Created by Christopher Hatton on 24/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

public typealias RGBPixelProcess = (RGBColor)-> RGBColor
public typealias HSVPixelProcess = (HSVColor)-> HSVColor


public struct PixelColorSource<PixelColor :Color>
{
    typealias T = (_ x: UInt, _ y: UInt) -> PixelColor
}

public func PixelIdentityProcess<PixelColor :Color>(_ input: PixelColor) -> PixelColor
{
    return input
}

public class RGBviaHSVProcessor
{
    public let hsvProcess: HSVPixelProcess
    
    public init(hsvProcess: @escaping HSVPixelProcess)
    {
        self.hsvProcess = hsvProcess
    }
    
    public func RGBPixelProcess(_ rgb: RGBColor) -> RGBColor
    {
        let
            hsvIn  = RGBtoHSV(rgb),
            hsvOut = hsvProcess(hsvIn)
            
        return HSVtoRGB(hsvOut)
    }
}
