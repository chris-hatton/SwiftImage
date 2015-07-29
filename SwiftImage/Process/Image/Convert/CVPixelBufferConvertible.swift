//
//  CVPixelBufferable.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 22/07/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

protocol CVPixelBufferConvertible
{
    func toCVPixelBuffer() -> CVPixelBuffer
}