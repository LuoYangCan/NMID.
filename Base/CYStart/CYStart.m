//
//  CYStart.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/4/26.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYStart.h"
#import "CYLoginViewController.h"
#import "CYHomeController.h"
@interface CYStart ()
@property(nonatomic,strong) CALayer *imageLayer;

@end

@implementation CYStart

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showImage];
    [self performSelector:@selector(initLogin) withObject:nil afterDelay:3];
    // Do any additional setup after loading the view.
}

-(void)initLogin{
    CYLoginViewController *LoginVC = [[CYLoginViewController alloc]init];
    LoginVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:LoginVC animated:nil completion:nil];
}

//-(void)gotoHomeView{
//    CYHomeController *home = [[CYHomeController alloc]init];
//    [self presentViewController:home animated:NO completion:nil];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 载入界面
- (void) showImage{
    UIImage *background = [UIImage imageNamed:@"background"];
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.view.layer addSublayer:self.imageLayer];
    self.imageLayer.contents = (__bridge id)(background.CGImage);
    
    [self performSelector:@selector(layerAnimation) withObject:nil afterDelay:1.0f];
    
    
}

-(void)layerAnimation{
    UIImage *LaunchImage = [UIImage imageNamed:@"Launch_Image"];
    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    contentsAnimation.fromValue = self.imageLayer.contents;
    contentsAnimation.toValue = (__bridge id)(LaunchImage.CGImage);
    contentsAnimation.duration = 2;
    self.imageLayer.contents = (__bridge id)(LaunchImage.CGImage);
    [self.imageLayer addAnimation:contentsAnimation forKey:nil];
    [self.imageLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:2.7f];
}


@end
