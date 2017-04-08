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
@end
