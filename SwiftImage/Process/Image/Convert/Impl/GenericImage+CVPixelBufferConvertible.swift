//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreVideo

extension GenericImage : CVPixelBufferConvertible
{
    public func toCVPixelBuffer() -> CVPixelBuffer
    {
        preconditionFailure()
    }
}