//
//  Pixels.swift
//  ResistAR
//
//  Created by Christopher Hatton on 24/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

typealias RGBPixelProcess = (RGBPixel)->RGBPixel
typealias HSVPixelProcess = (HSVPixel)->HSVPixel


struct PixelSource<PixelType : Pixel>
{
    typealias T = (_ x: UInt, _ y: UInt) -> PixelType
}

func PixelIdentityProcess<PixelType : Pixel>( _ input: PixelType) -> PixelType
{
    return input
}

class RGBviaHSVProcessor
{
    let hsvProcess: HSVPixelProcess
    
    init(hsvProcess: @escaping HSVPixelProcess)
    {
        self.hsvProcess = hsvProcess
    }
    
    func RGBPixelProcess(_ rgb: RGBPixel) -> RGBPixel
    {
        let
            hsvIn  = RGBtoHSV(rgb),
            hsvOut = hsvProcess(hsvIn)
            
        return HSVtoRGB(hsvOut)
    }
}
