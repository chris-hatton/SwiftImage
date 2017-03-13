//
//  HSVColor+ConvertibleColor.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

extension HSVColor : ConvertibleColor
{
    func convert() throws -> RGBColor
    {
        return HSVtoRGB(self)
    }
}
