//
//  !CVPixelBuffer+ConvertibleImage.swift
//  SwiftImage
//
//  Created by Christopher Hatton on 5/09/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

import Foundation

extension CVPixelBuffer : ConvertibleImage
{
    public func convert() -> CGImage
    {
        let ciImage: CIImage = self.convert()
        
        let temporaryContext : CIContext = CIContext()
        
        let rect : CGRect = CGRect( x: 0, y: 0, width: CGFloat( self.width ), height: CGFloat( self.height ) )
        
        return temporaryContext.createCGImage( ciImage, from: rect )!
    }
    
    public func convert() -> CIImage
    {
        return CIImage( cvPixelBuffer: self )
    }
    
    public func convert() -> UIImage
    {
        return UIImage( cgImage: convert() as CGImage )
    }
    
    public func convert() -> GenericImage<RGBPixel>
    {
        let cgImage : CGImage = self.convert()
        return cgImage.convert()
    }
}
