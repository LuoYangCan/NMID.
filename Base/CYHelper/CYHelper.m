//
//  CYHelper.m
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYHelper.h"
@implementation CYHelper
+(UIColor *)getColorfrom:(NSIndexPath *)IndexPath{
    int index = IndexPath.row % 6 ;
    switch (index) {
        case 0:
            return ROrange;
            break;
        case 1:
            return RRed;
            break;
        case 2:
            return [UIColor purpleColor];
            break;
        case 3:
            return RBlue;
            break;
        case 4:
            return [UIColor grayColor];
            break;
        case 5:
            return RGreen;
            break;
            
        default:
            return ROrange;
            break;
    }
}

+(NSString *)getFirstWordFrom:(NSArray *)StrArray andRow:(NSIndexPath *)indexPath{
    NSString *allWord = [StrArray objectAtIndex:indexPath.row];
    NSString *FirstWord = [allWord substringToIndex:1];
    return FirstWord;
}


+(UIColor *)colorwithRGB:(CGFloat)R andG:(CGFloat)G andB:(CGFloat)B andalpha:(CGFloat)alpha{
    UIColor *color = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:alpha];
    return color;
}

+(UIImageView *)getCycleImageViewwithx:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    UIImageView *Image = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:Image.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:Image.bounds.size];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = Image.bounds;
    masklayer.path = maskPath.CGPath;
    Image.layer.mask = masklayer;
    return Image;
}
@end
