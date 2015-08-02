//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage : ImmutableImage
{
    public typealias PixelType   = RGBPixel
    public typealias PixelSource = ()->PixelType?
    
    public func readRegion( region: ImageRegion ) -> PixelSource
    {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let
            width            : Int = Int( region.width ),
            height           : Int = Int ( region.height ),
            bitsPerComponent : Int = 8,
            bytesPerPixel    : Int = 4,
            bytesPerRow      : Int = (bytesPerPixel * width)
        
        let pixelPtr : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.alloc( bytesPerRow * height )
        
        let context : CGContext = CGBitmapContextCreate(
            pixelPtr,
            width,
            height,
            bitsPerComponent,
            bytesPerRow,
            rgbColorSpace,
            CGImageAlphaInfo.NoneSkipLast.rawValue
        )!
        
        UIGraphicsPushContext(context)
        
        self.drawAtPoint( CGPointMake( -CGFloat( region.x ), -CGFloat( region.y ) ) )
        
        UIGraphicsPopContext()
        
        var
            pixelIndex : Int = 0,
            pixelCount : Int = Int( region.width * region.height )
        
        let pixelSource : PixelSource =
        {
            let pixel : PixelType?
            
            if pixelIndex < pixelCount
            {
                let r : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                let g : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                let b : Double = Double( pixelPtr.memory / 255 )
                pixelPtr.advancedBy(1)
                
                pixelPtr.advancedBy(1) // Discard Alpha
                
                pixel = RGBPixel(r,g,b)
            }
            else
            {
                pixel = nil
            }
            
            ++pixelCount
            
            return pixel
        }
        
        return pixelSource
    }

    public var width : UInt
    {
        get { return UInt( self.size.width ) }
    }
    
    public var height : UInt
    {
        get { return UInt( self.size.height ) }
    }
}