//
//  Pixels.swift
//  ResistAR
//
//  Created by Christopher Hatton on 24/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

public typealias RGBPixelProcess = (RGBPixel)->RGBPixel
public typealias HSVPixelProcess = (HSVPixel)->HSVPixel


public struct PixelSource<PixelType : Pixel>
{
    typealias T = (_ x: UInt, _ y: UInt) -> PixelType
}

public func PixelIdentityProcess<PixelType : Pixel>( _ input: PixelType) -> PixelType
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
    
    public func RGBPixelProcess(_ rgb: RGBPixel) -> RGBPixel
    {
        let
            hsvIn  = RGBtoHSV(rgb),
            hsvOut = hsvProcess(hsvIn)
            
        return HSVtoRGB(hsvOut)
    }
}
