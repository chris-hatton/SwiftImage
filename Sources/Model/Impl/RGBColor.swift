//
//  RGBAColor.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 07/09/2014.
//  Copyright (c) 2014 AppDelegate. All rights reserved.
//

import Foundation

public struct RGBColor : Color
{
    static let doubleScale : Double = 255
    
    private var
        _red   : UInt8,
        _green : UInt8,
        _blue  : UInt8
    
    public mutating func set( red   : Int ) { _red   = UInt8(red   ) }
    public mutating func set( green : Int ) { _green = UInt8(green ) }
    public mutating func set( blue  : Int ) { _blue  = UInt8(blue  ) }
    
    public mutating func set( red   : Double ) { _red   = UInt8(red   * RGBColor.doubleScale) }
    public mutating func set( green : Double ) { _green = UInt8(green * RGBColor.doubleScale) }
    public mutating func set( blue  : Double ) { _blue  = UInt8(blue  * RGBColor.doubleScale) }
    
    public func red()   -> Int    { return Int(_red  ) }
    public func green() -> Int    { return Int(_green) }
    public func blue()  -> Int    { return Int(_blue ) }
    
    public func red()   -> Double { return Double(_red  ) / 255 }
    public func green() -> Double { return Double(_green) / 255 }
    public func blue()  -> Double { return Double(_blue ) / 255 }
    
    public func red()   -> Float { return Float(_red  ) / 255 }
    public func green() -> Float { return Float(_green) / 255 }
    public func blue()  -> Float { return Float(_blue ) / 255 }

    public init(_ red: Double, _ green: Double, _ blue: Double )
    {
        precondition(red   >= 0.0 && red   <= 1.0)
        precondition(green >= 0.0 && green <= 1.0)
        precondition(blue  >= 0.0 && blue  <= 1.0)
        
        _red   = UInt8(red   * RGBColor.doubleScale)
        _green = UInt8(green * RGBColor.doubleScale)
        _blue  = UInt8(blue  * RGBColor.doubleScale)
    }
}
