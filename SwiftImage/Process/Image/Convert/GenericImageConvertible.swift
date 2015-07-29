//
// Created by Christopher Hatton on 22/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

protocol GenericImageConvertible
{
    typealias PixelType : Pixel

    func toGenericImage() -> GenericImage<PixelType>
}