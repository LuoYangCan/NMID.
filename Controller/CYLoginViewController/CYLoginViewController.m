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
#import "CYHomeController.h"
#import "CYBaseController.h"
@interface CYLoginViewController ()
@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UITextField *logintext;
@property (nonatomic,strong) UITextField *Passwordtext;
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
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_logintext resignFirstResponder];
    [_Passwordtext resignFirstResponder];
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
    } completion:^(BOOL finished) {
        [self initMid];
        [self initBottom];
    }];
    
}

-(void)initMid{
    _logintext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth / 3 - 45,320, 200, 27)];
    UIImageView *loginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User-50"]];
    loginImage.frame = CGRectMake(-35,-5, 30, 30);
    _logintext.placeholder = @"  请输入用户名";
    _logintext.font = [UIFont systemFontOfSize:17];
    _logintext.leftView = loginImage;
    _logintext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_logintext];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(screenWidth / 3 -15, 347, 170, 1)];
    line1.backgroundColor = LineGray;
    [self.view addSubview:line1];
    
    _Passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/3 - 45, 370, 200, 27)];
    UIImageView *PasswordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Lock-50"]];
    PasswordImage.frame = CGRectMake(-35,-5, 30, 30);
    _Passwordtext.placeholder = @"  请输入密码";
    _Passwordtext.font =[UIFont systemFontOfSize:17];
    _Passwordtext.leftView = PasswordImage;
    _Passwordtext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_Passwordtext];
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
    
    UIButton *Visitor = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 + 50, 544, 80, 30)];
    [Visitor setTitle:@"游客访问" forState:UIControlStateNormal];
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    Visitor.titleLabel.font = [UIFont systemFontOfSize:14];
    [Visitor setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    LoginBtn.backgroundColor = LeftBlue;
    [Visitor addTarget:self action:@selector(VisitorLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:LoginBtn];
    [self.view addSubview:Visitor];
    
}
-(void)VisitorLogin{
    CYBaseController *base = [[CYBaseController alloc]init];
    [self presentViewController:base animated:YES completion:nil];
}
-(void)LoginBtnAction{
    
    
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
