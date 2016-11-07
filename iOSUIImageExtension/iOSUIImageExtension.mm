//
//  iOSUIImageExtension.m
//  iOSUIImageExtension
//
//  Created by Keith Hon on 11/7/16.
//  Copyright © 2016 Keith Hon. All rights reserved.
//

#import "iOSUIImageExtension.h"

@implementation UIImage (UIImageExtension)

// Initiailze an UIImage object with a byte array, whose memory will be released after initialization if releaseData flag is set to YES
-(id) initWithBytes :(unsigned char*) bytes image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData{
    
    // Copy the data from the input bytes to avoid being edited from the reference
    unsigned char* tmpBytes = new unsigned char[height * width * numberOfComponents];
    memcpy(tmpBytes, bytes, height * width * numberOfComponents);
    
    // CGDataProviderRef as a wrapper to raw memory blocks
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, tmpBytes, (height * width * numberOfComponents), NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = bitsPerComponent * numberOfComponents;
    int bytesPerRow = numberOfComponents * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    UIImage* tmp = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    // Release the input byte array to reclaim memory
    if (releaseData) {
        
        delete[] bytes;
        
    }
    
    return tmp.self;

}


@end
