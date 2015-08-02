//
//  CGImage+ImmutableImage.swift
//  ResistAR
//
//  Created by Christopher Hatton on 18/07/2015.
//  Copyright © 2015 AppDelegate. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGImage : ImmutableImage
{
    public typealias PixelType = RGBPixel
    public typealias PixelSource = () -> PixelType?
    
    public func readRegion( region: ImageRegion ) -> PixelSource
    {
        let
            bytesPerRow      : Int = CGImageGetBytesPerRow      ( self ),
            bitsPerPixel     : Int = CGImageGetBitsPerPixel     ( self ),
            bitsPerComponent : Int = CGImageGetBitsPerComponent ( self ),
            bytesPerPixel    : Int = bitsPerPixel / bitsPerComponent
        
        let rawData : CFData = CGDataProviderCopyData( CGImageGetDataProvider( self ) )!
        
        let pixelPtr = CFDataGetBytePtr( rawData )
        
        pixelPtr.advancedBy( Int( region.y ) * bytesPerRow ) + ( Int( region.x ) * bytesPerPixel )
        
        let widthOutsideRegion = Int( self.width - region.width )
        
        let nextLine : ()->Void = { pixelPtr.advancedBy( widthOutsideRegion * ( bytesPerPixel - 1 ) ) }
        
        let nextPixel : ()->PixelType =
        {
            let r : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(1)
            let g : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(1)
            let b : Double = Double( pixelPtr.memory / 255 )
            pixelPtr.advancedBy(1)
            
            return RGBPixel(r,g,b)
        }
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
    }
    
    public var width : UInt
    {
        get { return UInt( CGImageGetWidth( self ) ) }
    }
    
    public var height : UInt
    {
        get { return UInt( CGImageGetHeight( self ) ) }
    }
}