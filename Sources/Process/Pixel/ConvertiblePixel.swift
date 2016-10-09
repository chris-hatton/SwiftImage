//
//  ConvertiblePixel.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

public enum ConvertiblePixelError : Error
{
    case ConversionFailure
    case UnsupportedConversion( from: AnyObject.Type, to: AnyObject.Type )
}

protocol ConvertiblePixel : Pixel
{
    func convert<T:Pixel>() throws -> T
}

extension Pixel
{
    func convert<T:Pixel>() throws -> T
    {
        if T.self == Self.self { return self as! T }
        else
        {
            throw ConvertiblePixelError.UnsupportedConversion( from: T.self as! AnyObject.Type, to: Self.self as! AnyObject.Type )
        }
    }
}
