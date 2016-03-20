//
//  GenericImage+CGImageConvertible.m
//  SwiftImage
//
//  Created by Christopher Hatton on 16/08/2015.
//  Copyright © 2015 Chris Hatton. All rights reserved.
//



#import "GenericImage+CGImageConvertible.h"


@implementation GenericImage (CGImageConvertible)

const void * __nullable BDGenericImageCGImageConvertibleGetByte(void* info);
const void * __nullable BDGenericImageCGImageConvertibleGetByte(void* info)
{
    return info;
}

- (CGImageRef)toCGImage
{
    NSInteger
        width            = 10,
        height           = 10,
        bitsPerComponent = 8,
        bytesPerPixel    = 4,
        bitsPerPixel     = (bytesPerPixel * 8),
        bytesPerRow      = (bytesPerPixel * width);
    
    CGDataProviderDirectCallbacks cgDataProviderDirectCallbacks;
    
    // Set up direct data-provider callbacks
    {
        UInt32 version = (UInt32)0;
        
        CGDataProviderReleaseBytePointerCallback releaseBytePointer = nil;
        CGDataProviderGetBytesAtPositionCallback getBytesAtPosition = nil;
        CGDataProviderReleaseInfoCallback        releaseInfo        = nil;
        CGDataProviderGetBytePointerCallback     getBytePointer     = BDGenericImageCGImageConvertibleGetByte;
        
        CGDataProviderDirectCallbacks cgDataProviderDirectCallbacks;
        cgDataProviderDirectCallbacks.version            = version;
        cgDataProviderDirectCallbacks.getBytePointer     = getBytePointer;
        cgDataProviderDirectCallbacks.releaseBytePointer = releaseBytePointer;
        cgDataProviderDirectCallbacks.getBytesAtPosition = getBytesAtPosition;
        cgDataProviderDirectCallbacks.releaseInfo        = releaseInfo;
    }
    
    CGDataProviderRef dataProvider;
    
    // Set up direct data-provider
    {
        off_t size = (off_t)( bytesPerRow * height );
        
        dataProvider = CGDataProviderCreateDirect( self.pixels, size, &cgDataProviderDirectCallbacks );
    }
    
    CGImageRef cgImage;
    
    // Create image
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB()!,
        CGBitmapInfo bitmapInfo = CGBitmapInfo.AlphaInfoMask,
        decode            : UnsafePointer<CGFloat> = UnsafePointer<CGFloat>(),
        intent            : CGColorRenderingIntent = CGColorRenderingIntent.RenderingIntentDefault,
        shouldInterpolate : Bool                   = false
        
        cgImage = CGImageCreate(
                                width,
                                height,
                                bitsPerComponent,
                                bitsPerPixel,
                                bytesPerRow,
                                colorSpace,
                                bitmapInfo,
                                dataProvider,
                                decode,
                                shouldInterpolate,
                                intent
                                )!
    }
    
    return cgImage;
}

@end