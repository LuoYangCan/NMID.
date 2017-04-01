//
//  CYHelper.h
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface CYHelper : NSObject
+(UIColor *)getColorfrom:(NSIndexPath *)IndexPath;           //从几个背景色中选一个
+(NSString *)getFirstWordFrom:(NSArray *)StrArray andRow:(NSIndexPath *)indexPath;//取名字的第一个字
@end
