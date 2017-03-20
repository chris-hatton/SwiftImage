//
// Created by Christopher Hatton on 19/07/15.
// Copyright (c) 2015 Chris Hatton. All rights reserved.
//

import Foundation

public protocol Image
{
    associatedtype PixelColor : Color
    associatedtype PixelColorSource = (() -> PixelColor?)
    
    func read( region: ImageRegion ) -> PixelColorSource

    var width  : Int { get }
    var height : Int { get }
}

public extension Image
{
    subscript(x: Int, y: Int) -> PixelColor
    {
        get{ fatalError() }
        set{ fatalError() }
    }
    
    /*
     *  This default implementation of getPixel will be inefficient for most cases.
     *  Prefer to implement a more optimised version for concrete Image types.
     */
    func getPixel( _ x: Int, y: Int ) -> PixelColor?
    {
        let singlePixelRegion = ImageRegion.singlePixelRegion(x: x, y: y)
        
        let singlePixelColorSource : PixelColorSource = read( region: singlePixelRegion )
        
        let pixel : PixelColor? = (singlePixelColorSource as! ()-> PixelColor?)()
        
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
