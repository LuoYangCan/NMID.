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
#import <AFAuthSDK/AFAuthSDK.h>

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
    _logintext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth / 3 - 45,350, 200, 27)];
    UIImageView *loginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User-50"]];
    _logintext.delegate = self;
    loginImage.frame = CGRectMake(-35,-5, 30, 30);
    _logintext.placeholder = @"  请输入用户名";
    _logintext.font = [UIFont systemFontOfSize:17];
    _logintext.leftView = loginImage;
    _logintext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_logintext];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(screenWidth / 3 -15, 377, 170, 1)];
    line1.backgroundColor = LineGray;
    [self.view addSubview:line1];
    
    _Passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/3 - 45, 400, 200, 27)];
    UIImageView *PasswordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Lock-50"]];
    PasswordImage.frame = CGRectMake(-35,-5, 30, 30);
    _Passwordtext.delegate = self;
    _Passwordtext.placeholder = @"  请输入密码";
    _Passwordtext.secureTextEntry = YES;
    _Passwordtext.font =[UIFont systemFontOfSize:17];
    _Passwordtext.leftView = PasswordImage;
    _Passwordtext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_Passwordtext];
    UIView *line2= [[UIView alloc]initWithFrame:CGRectMake(screenWidth /3 -15 , 427, 170, 1)];
    line2.backgroundColor = LineGray;
    [self.view addSubview:line2];
}

-(void)initBottom{
    UIButton *LoginBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 -75, 517, 150, 50)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:LoginBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:LoginBtn.bounds.size];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = LoginBtn.bounds;
    masklayer.path = maskPath.CGPath;
    LoginBtn.layer.mask = masklayer;
    
    UIButton *Visitor = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 + 50, 574, 80, 30)];
    [Visitor setTitle:@"游客访问" forState:UIControlStateNormal];
    [LoginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    Visitor.titleLabel.font = [UIFont systemFontOfSize:14];
    [Visitor setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    LoginBtn.backgroundColor = LeftBlue;
    [Visitor addTarget:self action:@selector(VisitorLogin) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *regis = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 - 120, 574, 50, 30)];
    [regis setTitle:@"注册" forState:UIControlStateNormal];
    regis.titleLabel.font = [UIFont systemFontOfSize:14];
    [regis setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [regis addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    [LoginBtn addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth / 2 - 80, 620, 30, 30)];
    imageView.image = [UIImage imageNamed:@"zfb"];
    
    UIButton *zfbLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth / 2 - 47, 620, 100, 30)];
    [zfbLoginBtn addTarget:self action:@selector(AliLogin) forControlEvents:UIControlEventTouchUpInside];
    [zfbLoginBtn setTitle:@"支付宝登陆" forState:UIControlStateNormal];
    zfbLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [zfbLoginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [self.view addSubview:LoginBtn];
    [self.view addSubview:Visitor];
    [self.view addSubview:regis];
    [self.view addSubview:zfbLoginBtn];
    [self.view addSubview:imageView];
    
}
-(void)VisitorLogin{
    CYBaseController *base = [[CYBaseController alloc]init];
    [self presentViewController:base animated:YES completion:nil];
}
- (void)AliLogin {
    //你在info中/或plist中设置的appScheme
    NSString *appScheme = @"LiuBinScheme://";
    //authStr参数后台获取！和开发中心配置的app有关系，包含appid\name等等信息。
    NSString *authStr = @"apiname=com.alipay.account.auth&app_id= 2019051464573611&app_name=mc&auth_type=AUTHACCOUNT&biz_type=openservice&method=alipay.open.auth.sdk.code.get&pid=2088212105637072&product_id=APP_FAST_LOGIN&scope=kuaijie&sign_type=RSA2&target_id=20141225850&sign=fMcp4GtiM6rxSIeFnJCVePJKV43eXrUP86CQgiLhDHH2u%2FdN75eEvmywc2ulkm7qKRetkU9fbVZtJIqFdMJcJ9Yp%2BJI%2FF%2FpESafFR6rB2fRjiQQLGXvxmDGVMjPSxHxVtIqpZy5FDoKUSjQ2%2FILDKpu3%2F%2BtAtm2jRw1rUoMhgt0%3D";
    //没有安装支付宝客户端的跳到网页授权时会在这个方法里回调
    [[AFAuthSDK defaultService] authv2WithInfo:authStr fromScheme:appScheme callback:^(NSDictionary *result) {
        // 解析 auth code
        NSString *resultString = result[@"result"];
        NSString *authCode = nil;
        if (resultString.length>0) {
            NSArray *resultArr = [resultString componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
                if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                    authCode = [subResult substringFromIndex:10];
                    break;
                }
            }
        }
        NSLog(@"resultString = %@",resultString);
        //        NSLog(@"authv2WithInfo授权结果 authCode = %@", authCode?:@"");
    }];
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
        if (!response) {
            [[CYProgressHUD sharedHUD]showText:@"服务器连接错误" inView:self.view HideAfterDelay:1.0f];
            return;
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

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_logintext resignFirstResponder];
    [_Passwordtext resignFirstResponder];
    return YES;
}
@end
