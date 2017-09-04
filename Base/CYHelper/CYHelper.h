//
//  CYHelper.h
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+Addition.h"
typedef NS_ENUM(NSInteger,PostType){
    CYSignln,
    CYSignUp,
    CYModifyUser,
    CYAddPlan,
    CYDelPlan,
    CYAddMoment,
    CYDelMoment,
    CYAddDiscuss,
    CYDelDiscuss,
};
@interface CYHelper : NSObject

 //从几个背景色中选一个
+(UIColor *)getColorfrom:(NSIndexPath *)IndexPath;




//取名字的第一个字
+(NSString *)getFirstWordFrom:(NSArray *)StrArray andRow:(NSIndexPath *)indexPath;




//RGB颜色
+(UIColor *)colorwithRGB:(CGFloat)R andG:(CGFloat)G andB:(CGFloat)B andalpha:(CGFloat)alpha;




//拿到原型的ImageView
+(UIImageView *)getCycleImageViewwithx:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;
@end

#define screenWidth  [UIScreen mainScreen].bounds.size.width


#define screenHeight [UIScreen mainScreen].bounds.size.height


#define LeftOffX screenWidth * 0.81


#define LeftBlue [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1]


#define RGreen [UIColor colorWithRed:34/255.0 green:139/255.0 blue:34/255.0 alpha:1]


#define RBlue [UIColor colorWithRed:8/255.0 green:46/255.0 blue:84/255.0 alpha:1]


#define ROrange [UIColor colorWithRed:255/255.0 green:125/255.0 blue:64/255.0 alpha:1]


#define RRed [UIColor colorWithRed:255/255.0 green:69/255.0 blue:0/255.0 alpha:1]


#define LineGray [UIColor colorWithRed:128/255.0 green:138/255.0 blue:135/255.0 alpha:1]


#define GrayWhite [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]


#define NormalSize CGRectMake(0, 70, screenWidth, screenHeight)


#define wholeScreen CGRectMake(0, 0, screenWidth, screenHeight)


#define comeSize CGRectMake(screenWidth ,0 ,screenWidth, screenHeight)


#define kBackgroundGray [UIColor colorWithRGBHex:0xf7f7f7]


#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
