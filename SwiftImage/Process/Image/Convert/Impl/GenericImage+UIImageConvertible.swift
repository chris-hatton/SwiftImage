//
//  GenericImage+UIImageConvertible.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 02/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

import Foundation

extension GenericImage : UIImageConvertible
{
    public func  toUIImage() -> UIImage
    {
        let cgImage : CGImage = self.toCGImage()
        
        return UIImage(CGImage: cgImage)
    }
}
