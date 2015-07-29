//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

protocol ImmutableImage
{
    typealias PixelType : Pixel
    typealias PixelSource = () -> PixelType?
    
    func readRegion( region: ImageRegion ) -> PixelSource

    var width  : UInt { get }
    var height : UInt { get }
}

extension ImmutableImage
{
    func getPixel( x: UInt, y: UInt ) -> PixelType?
    {
        let singlePixelRegion = ImageRegion.singlePixelRegion(x, y: y)
        
        let singlePixelSource : PixelSource = readRegion( singlePixelRegion )
        
        return nil
    }
}


/*
func getHSVImageArea(startX:UInt, startY:UInt, width:UInt, height:UInt) -> GenericImage<HSVPixel>
{
var output : [[HSVPixel]] = [[HSVPixel]]()

for y in 0 ..< height
{
for x in 0 ..< width
{
let rgbPixel = getRGB( ( startX + x ), y: ( startY + y ) )

let hsvPixel = RGBtoHSV(rgbPixel)

output[Int(x)][Int(y)] = hsvPixel
}
}

return output
}
*/