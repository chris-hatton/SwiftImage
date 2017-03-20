//
//  RGBAColor.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

public struct RGBAColor: Color
{
    static let doubleScale : Double = 255
    
    private var
        _red   : UInt8,
        _green : UInt8,
        _blue  : UInt8,
        _alpha : UInt8
    
    public mutating func set( red   : Int ) { _red   = UInt8(red   ) }
    public mutating func set( green : Int ) { _green = UInt8(green ) }
    public mutating func set( blue  : Int ) { _blue  = UInt8(blue  ) }
    public mutating func set( alpha : Int ) { _alpha = UInt8(alpha ) }
    
    public mutating func set( red   : Double ) { _red   = UInt8(red   * RGBColor.doubleScale) }
    public mutating func set( green : Double ) { _green = UInt8(green * RGBColor.doubleScale) }
    public mutating func set( blue  : Double ) { _blue  = UInt8(blue  * RGBColor.doubleScale) }
    public mutating func set( alpha : Double ) { _alpha = UInt8(alpha * RGBColor.doubleScale) }
    
    public func red()   -> Int    { return Int(_red  ) }
    public func green() -> Int    { return Int(_green) }
    public func blue()  -> Int    { return Int(_blue ) }
    public func alpha() -> Int    { return Int(_alpha) }
    
    public func red()   -> Double { return Double(_red  ) / 255 }
    public func green() -> Double { return Double(_green) / 255 }
    public func blue()  -> Double { return Double(_blue ) / 255 }
    public func alpha() -> Double { return Double(_alpha) / 255 }
    
    public func red()   -> Float { return Float(_red  ) / 255 }
    public func green() -> Float { return Float(_green) / 255 }
    public func blue()  -> Float { return Float(_blue ) / 255 }
    public func alpha() -> Float { return Float(_alpha) / 255 }

    public init(_ red: Double, _ green: Double, _ blue: Double, _ alpha: Double = 1.0)
    {
        precondition(red   >= 0.0 && red   <= 1.0)
        precondition(green >= 0.0 && green <= 1.0)
        precondition(blue  >= 0.0 && blue  <= 1.0)
        precondition(alpha >= 0.0 && alpha <= 1.0)
        
        _red   = UInt8(red   * RGBColor.doubleScale)
        _green = UInt8(green * RGBColor.doubleScale)
        _blue  = UInt8(blue  * RGBColor.doubleScale)
        _alpha = UInt8(alpha * RGBColor.doubleScale)
    }
}
