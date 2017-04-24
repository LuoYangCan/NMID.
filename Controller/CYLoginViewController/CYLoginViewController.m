//
//  CYLoginViewController.m
//  Young Eagles
//
//  Created by NMID on 2017/4/22.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "CYLoginViewController.h"
#import "CYHelper.h"
@interface CYLoginViewController ()
@property (nonatomic,strong) UIImageView *image;
@end

@implementation CYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setup{
    [self initTop];
    [self initMid];
    [self initBottom];
}

-(void)initTop{
    _image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base"]];
    _image.frame = CGRectMake(screenWidth /3-8.5, 158.3, 155, 155);
    [self.view addSubview:_image];
    [self performSelector:@selector(Loginanimate) withObject:nil afterDelay:0.01];
}
-(void)Loginanimate{
    [UIView animateWithDuration:0.3 animations:^{
        _image.frame = CGRectMake(screenWidth / 2 -90 ,50, 180, 180);
    }];

}

-(void)initMid{
    UITextField *logintext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth / 3 - 45,320, 200, 27)];
    UIImageView *loginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User-50"]];
    loginImage.frame = CGRectMake(-35,-5, 30, 30);
    logintext.placeholder = @"  请输入用户名";
    logintext.font = [UIFont systemFontOfSize:17];
    logintext.leftView = loginImage;
    logintext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:logintext];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(screenWidth / 3 -15, 347, 170, 1)];
    line1.backgroundColor = LineGray;
    [self.view addSubview:line1];
    
    UITextField *Passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/3 - 45, 370, 200, 27)];
    UIImageView *PasswordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Lock-50"]];
    PasswordImage.frame = CGRectMake(-35,-5, 30, 30);
    Passwordtext.placeholder = @"  请输入密码";
    Passwordtext.font =[UIFont systemFontOfSize:17];
    Passwordtext.leftView = PasswordImage;
    Passwordtext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:Passwordtext];
    UIView *line2= [[UIView alloc]initWithFrame:CGRectMake(screenWidth /3 -15 , 397, 170, 1)];
    line2.backgroundColor = LineGray;
    [self.view addSubview:line2];
}

-(void)initBottom{
    UIButton *LoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 -75, 487, 150, 50)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:LoginBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:LoginBtn.bounds.size];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = LoginBtn.bounds;
    
    masklayer.path = maskPath.CGPath;
    LoginBtn.layer.mask = masklayer;
    
    
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    LoginBtn.backgroundColor = [UIColor greenColor];
    [LoginBtn addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];
    
}

-(void)LoginBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
