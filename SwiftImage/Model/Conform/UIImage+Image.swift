//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation
import CoreGraphics

extension UIImage : Image
{
    public typealias PixelType   = RGBPixel
    public typealias PixelSource = ()->PixelType?
    
    public func read( region: ImageRegion ) -> PixelSource
    {
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let
            width            : Int = Int( region.width  ),
            height           : Int = Int( region.height ),
            bitsPerComponent : Int = 8,
            bytesPerPixel    : Int = 4,
            bytesPerRow      : Int = (bytesPerPixel * width)
        
        let byteCount = bytesPerRow * height
        
        let pixelPtr : UnsafeMutablePointer<UInt8> = UnsafeMutablePointer<UInt8>.allocate(capacity: byteCount )
        
        let context : CGContext = CGContext(
            data             : pixelPtr,
            width            : width,
            height           : height,
            bitsPerComponent : bitsPerComponent,
            bytesPerRow      : bytesPerRow,
            space            : rgbColorSpace,
            bitmapInfo       : CGImageAlphaInfo.noneSkipLast.rawValue
        )!
        
        UIGraphicsPushContext(context)
        
        self.draw( at: CGPoint.zero ) //CGPoint( x: -CGFloat( region.x ), y: -CGFloat( region.y ) )
        
        print("Region x:\(region.x), t:\(region.y)")
        
        let anySet : Bool = (0 ..< byteCount).reduce( false ) { return $0 || pixelPtr.advanced(by: $1).pointee > 0 }
        
        print("Is any set? \(anySet)")
        
        
        var pixelIndex : Int = 0
        var byteIndex  : Int = 0
        let pixelCount : Int = Int( region.width * region.height )
        
        let pixelSource : PixelSource =
        {
            let pixel : PixelType?
            
            if pixelIndex < pixelCount
            {
                let r : Double = Double( pixelPtr[byteIndex] ) / Double(255);   byteIndex += 1
                let g : Double = Double( pixelPtr[byteIndex] ) / Double(255);   byteIndex += 1
                let b : Double = Double( pixelPtr[byteIndex] ) / Double(255);   byteIndex += 1
                
                byteIndex += 1 // Skip Alpha
                
                pixel = RGBPixel(r,g,b)
                
                pixelIndex += 1
            }
            else
            {
                pixel = nil
            }
            
            return pixel
        }
        
        UIGraphicsPopContext()
        
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
