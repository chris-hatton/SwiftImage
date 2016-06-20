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
    
    public func readRegion( _ region: ImageRegion ) -> PixelSource
    {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let
            width            : Int = Int( region.width ),
            height           : Int = Int ( region.height ),
            bitsPerComponent : Int = 8,
            bytesPerPixel    : Int = 4,
            bytesPerRow      : Int = (bytesPerPixel * width)
        
        var pixelPtr : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>( allocatingCapacity: bytesPerRow * height )
        
        let context : CGContext = CGContext(
            data: pixelPtr,
            width: width,
            height: height,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: rgbColorSpace,
            bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue
        )!
        
        UIGraphicsPushContext(context)
        
        self.draw( at: CGPoint( x: -CGFloat( region.x ), y: -CGFloat( region.y ) ) )
        
        UIGraphicsPopContext()
        
        var
            pixelIndex : Int = 0,
            pixelCount : Int = Int( region.width * region.height )
        
        let pixelSource : PixelSource =
        {
            let pixel : PixelType?
            
            if pixelIndex < pixelCount
            {
                let r : Double = Double( pixelPtr.pointee / 255 )
                pixelPtr = pixelPtr.advanced(by: 1)
                let g : Double = Double( pixelPtr.pointee / 255 )
                pixelPtr = pixelPtr.advanced(by: 1)
                let b : Double = Double( pixelPtr.pointee / 255 )
                pixelPtr = pixelPtr.advanced(by: 1)
                
                pixelPtr = pixelPtr.advanced(by: 1) // Discard Alpha
                
                pixel = RGBPixel(r,g,b)
            }
            else
            {
                pixel = nil
            }
            
            pixelCount += 1
            
            return pixel
        }
        
        return pixelSource
    }

    public var width : Int
    {
        get { return Int( self.size.width ) }
    }
    
    public var height : Int
    {
        get { return Int( self.size.height ) }
    }
}
