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

-(id) initWithBytes :(unsigned char*) bytes image_height:(int)height image_width:(int) width numberOfComponents:(int) numberOfComponents releaseData:(bool) releaseData;

@end
