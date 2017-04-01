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
            return [UIColor orangeColor];
            break;
        case 1:
            return [UIColor redColor];
            break;
        case 2:
            return [UIColor purpleColor];
            break;
        case 3:
            return [UIColor blueColor];
            break;
        case 4:
            return [UIColor grayColor];
            break;
        case 5:
            return [UIColor greenColor];
            break;
            
        default:
            return [UIColor orangeColor];
            break;
    }
}

+(NSString *)getFirstWordFrom:(NSArray *)StrArray andRow:(NSIndexPath *)indexPath{
    NSString *allWord = [StrArray objectAtIndex:indexPath.row];
    NSString *FirstWord = [allWord substringToIndex:1];
    return FirstWord;
}
@end
