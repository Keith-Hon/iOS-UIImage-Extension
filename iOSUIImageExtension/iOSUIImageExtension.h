//
//  iOSUIImageExtension.h
//  iOSUIImageExtension
//
//  Created by Keith Hon on 11/7/16.
//  Copyright © 2016 Keith Hon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (UIImageExtension)

// Initiailze an UIImage object with a byte array, whose memory will be released after initialization if releaseData flag is set to YES
-(id) initWithBytes :(unsigned char*) data image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData setAlpha:(bool) setAlpha;

// Initiailze an UIImage object with a float array, whose memory will be released after initialization if releaseData flag is set to YES
-(id) initWithFloats:(float*) data image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData setAlpha:(bool) setAlpha;

// Get a byte array copy from an UIImage. The return array contains four channel with alpha value at the last channel if withAlpha is true and 255 otherwise
-(unsigned char*) getBytes: (bool)withAlpha;

@end
