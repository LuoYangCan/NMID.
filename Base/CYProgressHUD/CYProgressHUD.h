//
//  CYProgressHUD.h
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/4.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface CYProgressHUD : MBProgressHUD


+(CYProgressHUD *)sharedHUD;





/**
 显示文字提示
 */

-(void)showText:(NSString *)text inView:(UIView *)view HideAfterDelay:(NSTimeInterval)delay;



/**
 隐藏
 */

- (void)hideAfterDelay:(NSTimeInterval)delay;








/**
 旋转。。
*/
- (void)rotateWithText:(NSString *)text inView:(UIView *)view;
@end
