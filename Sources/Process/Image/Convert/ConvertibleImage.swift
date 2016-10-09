//
//  CVPixelBufferable.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 22/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

public enum ConvertibleImageError : Error
{
    case ConversionFailure
    case UnsupportedConversion( from: AnyObject.Type, to: AnyObject.Type )
}

public protocol ConvertibleImage : Image
{
    func convert<T:Image>() throws -> T
}

public extension ConvertibleImage
{
    public func convert<T:Image>() throws -> T
    {
        if T.self == Self.self { return self as! T }
        else
        {
            throw ConvertibleImageError.UnsupportedConversion( from: T.self as! AnyObject.Type, to: Self.self as! AnyObject.Type )
        }
    }
}
