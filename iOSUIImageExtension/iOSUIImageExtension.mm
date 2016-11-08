//
//  iOSUIImageExtension.m
//  iOSUIImageExtension
//
//  Created by Keith Hon on 11/7/16.
//  Copyright © 2016 Keith Hon. All rights reserved.
//

#import "iOSUIImageExtension.h"

@implementation UIImage (UIImageExtension)

-(void) checkNumberOfComponents: (int) numberOfComponents {
    
    NSAssert(numberOfComponents == 3 || numberOfComponents == 4, @"Parameter numberOfComponents can be only either 3 or 4");
}

-(void) checkSetAlpha: (int) numberOfComponents setAlpha: (bool) setAlpha {
    
    if (setAlpha) {
        
        NSAssert(numberOfComponents == 4, @"To set alpha in the output UIImage, the number of components in the input image must be 4");
    }
    
}

-(id) initWithBytes: (unsigned char*) data image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData setAlpha:(bool) setAlpha{
    
    [self checkNumberOfComponents: numberOfComponents];
    [self checkSetAlpha:numberOfComponents setAlpha:setAlpha];
    
    // Copy the data from the input bytes to avoid being edited from the reference
    unsigned char* tmpBytes = new unsigned char[height * width * numberOfComponents];
    memcpy(tmpBytes, data, height * width * numberOfComponents);
    
    // CGDataProviderRef as a wrapper to raw memory blocks
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, tmpBytes, (height * width * numberOfComponents), NULL);
    
    int bitsPerComponent = 8;
    int bitsPerPixel = bitsPerComponent * numberOfComponents;
    int bytesPerRow = numberOfComponents * width;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    
    if (setAlpha) {
        
        bitmapInfo = kCGImageAlphaPremultipliedLast | bitmapInfo;
        
    }
    
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
    UIImage* tmp = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    
    // Release the input byte array to reclaim memory
    if (releaseData) {
        
        delete[] data;
        
    }
    
    return tmp.self;

}

-(id) initWithFloats: (float*) data image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData setAlpha:(bool) setAlpha{
    
    [self checkNumberOfComponents: numberOfComponents];
    [self checkSetAlpha:numberOfComponents setAlpha:setAlpha];
    
    unsigned char* tmp = new unsigned char[width * height * numberOfComponents];
    
    for(int i = 0; i < height; i++) {
        
        for(int j = 0; j < width; j++){
            
            int idx = numberOfComponents * (i * width + j);
            
            tmp[idx] = static_cast<char>(data[idx] * 255);
            tmp[idx + 1] = static_cast<char>(data[idx + 1] * 255);
            tmp[idx + 2] = static_cast<char>(data[idx + 2] * 255);
            
            if (setAlpha) {
                
                tmp[idx + 3] = static_cast<char>(data[idx + 3] * 255);
                
            }
            
        }
        
    }
    
    // Release the input byte array to reclaim memory
    if (releaseData) {
        
        delete[] data;
        
    }
    
    return [[UIImage alloc] initWithBytes:tmp image_height:height image_width:width numberOfComponents:numberOfComponents releaseData:YES setAlpha:setAlpha];
    
}

-(unsigned char*) getBytes: (bool)withAlpha {
    
    // Output data always has four channels
    unsigned char* outData = new unsigned char[4 * (int)self.size.height * (int)self.size.width]();
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(self.CGImage);
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    
    if (withAlpha) {
        
        bitmapInfo = kCGImageAlphaPremultipliedLast | bitmapInfo;
        
    } else {
        
        bitmapInfo = kCGImageAlphaNoneSkipLast| bitmapInfo;
    }
    
    CGContextRef contextRef = CGBitmapContextCreate(outData, self.size.width, self.size.height, CGImageGetBitsPerComponent(self.CGImage), CGImageGetBytesPerRow(self.CGImage), colorSpace, bitmapInfo);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    
    CGContextRelease(contextRef);
    
    return outData;
    
}

@end
