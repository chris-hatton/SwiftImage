//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

public protocol Image
{
    associatedtype PixelType : Pixel
    associatedtype PixelSource = (() -> PixelType?)
    
    func read( region: ImageRegion ) -> PixelSource

    var width  : Int { get }
    var height : Int { get }
}

public extension Image
{
    func getPixel( _ x: Int, y: Int ) -> PixelType?
    {
        let singlePixelRegion = ImageRegion.singlePixelRegion(x: x, y: y)
        
        let singlePixelSource : PixelSource = read( region: singlePixelRegion )
        
        let pixel : PixelType? = (singlePixelSource as! ()->PixelType?)()
        
        return pixel
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
