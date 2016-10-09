//
//  CGImage+ImmutableImage.swift
//  ResistAR
//
//  Created by Christopher Hatton on 18/07/2015.
//  Copyright © 2015 AppDelegate. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGImage : Image
{
    public typealias PixelType = RGBPixel
    public typealias PixelSource = () -> PixelType?
    
    public func read( region: ImageRegion ) -> PixelSource
    {
        let bytesPerPixel : Int = bitsPerPixel / bitsPerComponent
        
        let rawData : CFData = self.dataProvider!.data!
        
        guard var pixelPtr = CFDataGetBytePtr( rawData ) else { fatalError() }
        
        pixelPtr = pixelPtr.advanced( by: Int( region.y ) * bytesPerRow ) + ( Int( region.x ) * bytesPerPixel )
        
        let widthOutsideRegion = Int( self.width - region.width )
        
        let nextLine : ()->Void = { pixelPtr = pixelPtr.advanced( by: widthOutsideRegion * ( bytesPerPixel - 1 ) ) }
        
        let nextPixel : ()->PixelType =
        {
            let r : Double = Double( pixelPtr.pointee / 255 )
            pixelPtr = pixelPtr.advanced(by:1)
            let g : Double = Double( pixelPtr.pointee / 255 )
            pixelPtr = pixelPtr.advanced(by:1)
            let b : Double = Double( pixelPtr.pointee / 255 )
            pixelPtr = pixelPtr.advanced(by:1)
            
            return RGBPixel(r,g,b)
        }
        
        return regionRasterSource( region, nextPixel: nextPixel, nextLine: nextLine )
    }
}
