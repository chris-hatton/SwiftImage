//
//  HSVPixel+ConvertiblePixel.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

extension HSVPixel : ConvertiblePixel
{
    func convert() throws -> RGBPixel
    {
        return HSVtoRGB(self)
    }
}
