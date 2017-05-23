//
//  UIColor+Addition.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/15.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)
+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end
