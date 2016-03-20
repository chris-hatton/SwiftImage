//
//  GenericImage+CGImageConvertible.h
//  SwiftImage
//
//  Created by Christopher Hatton on 16/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GenericImage;
@protocol CGImageConvertible;

@interface GenericImage (CGImageConvertible) <CGImageConvertible>

@end
