//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

extension CVPixelBuffer : GenericImageConvertible
{
    public func toGenericImage() -> GenericImage<PixelType>
    {
        preconditionFailure()
    }
}