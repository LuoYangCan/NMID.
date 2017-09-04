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
#import "CYNetwork.h"
#import "CYProgressHUD.h"
#import "CYRegisterView.h"

@interface CYLoginViewController ()<UITextFieldDelegate>
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
    _logintext.delegate = self;
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
    _Passwordtext.delegate = self;
    _Passwordtext.placeholder = @"  请输入密码";
    _Passwordtext.secureTextEntry = YES;
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
    
    
    UIButton *regis = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 - 120, 544, 50, 30)];
    [regis setTitle:@"注册" forState:UIControlStateNormal];
    regis.titleLabel.font = [UIFont systemFontOfSize:14];
    [regis setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [regis addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:LoginBtn];
    [self.view addSubview:Visitor];
    [self.view addSubview:regis];
    
}
-(void)VisitorLogin{
    CYBaseController *base = [[CYBaseController alloc]init];
    [self presentViewController:base animated:YES completion:nil];
}
-(void)regis{
    CYRegisterView *regis = [[CYRegisterView alloc]init];
    [self presentViewController:regis animated:YES completion:nil];
}
-(void)LoginBtnAction{
    if ([_logintext.text isEqualToString:@""] || [_Passwordtext.text isEqualToString:@""]) {
        [[CYProgressHUD sharedHUD]showText:@"请输入用户名或密码" inView:self.view HideAfterDelay:1.0f];
        return;
    }
    [[CYProgressHUD sharedHUD]rotateWithText:@"正在登陆" inView:self.view];
    NSString * LoginStr = [NSString stringWithFormat:@"tel=%@&pwd=%@",_logintext.text,_Passwordtext.text];
    @weakify(self);
    [[CYNetwork sharedManager]post_RequestwithData:LoginStr Completion:^(NSError * error, id response, NSURLSessionTask * task) {
        @strongify(self);
        if (error) {
            [[CYProgressHUD sharedHUD]hideAfterDelay:0];
            [[CYProgressHUD sharedHUD]showText:[NSString stringWithFormat:@"%@",error.localizedDescription ] inView:self.view HideAfterDelay:1.0f];
            return ;
        }
        if (![response[@"status"] boolValue] && [response[@"code"] longValue] == 500) {
            [[CYProgressHUD sharedHUD]hideAfterDelay:0];
            [[CYProgressHUD sharedHUD]showText:@"用户名或密码错误" inView:self.view HideAfterDelay:1.0f];
        }else if ([response[@"status"] boolValue]){
            CYBaseController *base = [[CYBaseController alloc]init];
            [self presentViewController:base animated:YES completion:nil];
        }
        
    }];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_logintext resignFirstResponder];
    [_Passwordtext resignFirstResponder];
    return YES;
}
@end
