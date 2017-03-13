//
//  ConvertibleColor.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

public enum ColorConversionError: Error
{
    case ConversionFailure
    case UnsupportedConversion( from: AnyObject.Type, to: AnyObject.Type )
}

public protocol ConvertibleColor : Color
{
    func convert<T:Color>() throws -> T
}

extension Color
{
    public func convert<T:Color>() throws -> T
    {
        if T.self == Self.self { return self as! T }
        else
        {
            throw ColorConversionError.UnsupportedConversion( from: T.self as! AnyObject.Type, to: Self.self as! AnyObject.Type )
        }
    }
}
