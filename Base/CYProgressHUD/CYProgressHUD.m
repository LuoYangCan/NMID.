//
//  CYProgressHUD.m
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/4.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYProgressHUD.h"
static CYProgressHUD *ProgressHUD = nil;
@implementation CYProgressHUD
{
    MBProgressHUD *hud;
}

+(CYProgressHUD *)sharedHUD{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ProgressHUD =  [[CYProgressHUD alloc]init];
    });
    return ProgressHUD;
}
-(void)showText:(NSString *)text inView:(UIView *)view HideAfterDelay:(NSTimeInterval)delay{
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.mode =MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:delay];
}



- (void)rotateWithText:(NSString *)text inView:(UIView *)view
{
    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)hideAfterDelay:(NSTimeInterval)delay
{
    [hud hide:YES afterDelay:delay];
}
@end
