//
//  GenericImage+Line.swift
//  SwiftImage-Apple
//
//  Created by Christopher Hatton on 21/10/2016.
//  Copyright © 2016 Chris Hatton. All rights reserved.
//

extension GenericImage
{
    /*
    public func drawLine( x: Int, y: Int, x2: Int, y2: Int, color: UIColor)
    {
        int w = x2 - x ;
        int h = y2 - y ;
        int dx1 = 0, dy1 = 0, dx2 = 0, dy2 = 0 ;
        if (w<0) dx1 = -1 ; else if (w>0) dx1 = 1 ;
        if (h<0) dy1 = -1 ; else if (h>0) dy1 = 1 ;
        if (w<0) dx2 = -1 ; else if (w>0) dx2 = 1 ;
        int longest = Math.abs(w) ;
        int shortest = Math.abs(h) ;
        if (!(longest>shortest)) {
        longest = Math.abs(h) ;
        shortest = Math.abs(w) ;
        if (h<0) dy2 = -1 ; else if (h>0) dy2 = 1 ;
        dx2 = 0 ;
        }
        int numerator = longest >> 1 ;
        for (int i=0;i<=longest;i++) {
        putpixel(x,y,color) ;
        numerator += shortest ;
        if (!(numerator<longest)) {
        numerator -= longest ;
        x += dx1 ;
        y += dy1 ;
        } else {
        x += dx2 ;
        y += dy2 ;
        }
        }
    }
 */
}
