//
//  CYRegisterView.m
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2017/9/4.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYRegisterView.h"
#import "CYHelper.h"
#import "CYNetwork.h"
#import "CYProgressHUD.h"

@interface CYRegisterView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *logintext;
@property (nonatomic,strong) UITextField *Passwordtext;
@end

@implementation CYRegisterView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_logintext resignFirstResponder];
    [_Passwordtext resignFirstResponder];
}
-(void)setup{
    self.view.backgroundColor = [UIColor whiteColor];
    [self initRegisUI];
    [self initTopUI];
}
-(void)initRegisUI{
    _logintext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth / 3 - 45,380, 200, 27)];
    UIImageView *loginImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"User-50"]];
    loginImage.frame = CGRectMake(-35,-5, 30, 30);
    _logintext.delegate = self;
    _logintext.placeholder = @"  请输入用户名";
    _logintext.font = [UIFont systemFontOfSize:17];
    _logintext.leftView = loginImage;
    _logintext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_logintext];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(screenWidth / 3 -15, 407, 170, 1)];
    line1.backgroundColor = LineGray;
    [self.view addSubview:line1];
    
    _Passwordtext = [[UITextField alloc]initWithFrame:CGRectMake(screenWidth/3 - 45, 430, 200, 27)];
    UIImageView *PasswordImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Lock-50"]];
    PasswordImage.frame = CGRectMake(-35,-5, 30, 30);
    _Passwordtext.delegate = self;
    _Passwordtext.placeholder = @"  请输入密码";
    _Passwordtext.secureTextEntry = YES;
    _Passwordtext.font =[UIFont systemFontOfSize:17];
    _Passwordtext.leftView = PasswordImage;
    _Passwordtext.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:_Passwordtext];
    UIView *line2= [[UIView alloc]initWithFrame:CGRectMake(screenWidth /3 -15 , 457, 170, 1)];
    line2.backgroundColor = LineGray;
    [self.view addSubview:line2];
    
    UIButton *RegisBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth /2 -75, 547, 150, 50)];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:RegisBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:RegisBtn.bounds.size];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = RegisBtn.bounds;
    masklayer.path = maskPath.CGPath;
    RegisBtn.layer.mask = masklayer;
    
    [RegisBtn setTitle:@"注册" forState:UIControlStateNormal];
    RegisBtn.backgroundColor = LeftBlue;
    [RegisBtn addTarget:self action:@selector(RegisBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:RegisBtn];
}
-(void)RegisBtnAction{
    if ([_logintext.text isEqualToString:@""] || [_Passwordtext.text isEqualToString:@""]) {
        [[CYProgressHUD sharedHUD]showText:@"请输入用户名或密码" inView:self.view HideAfterDelay:1.0f];
        return;
    }
    [[CYProgressHUD sharedHUD]rotateWithText:@"正在提交" inView:self.view];
    NSDictionary *dic = @{ @"tel":_logintext,
                           @"pwd":_Passwordtext
                           };
    [[CYNetwork sharedManager]RequestwithData:dic andURLParameters:@"/signUp" Completion:^(NSError * error, id response, NSURLSessionTask * task) {
        if (error) {
            [[CYProgressHUD sharedHUD]hideAfterDelay:0];
            [[CYProgressHUD sharedHUD]showText:[NSString stringWithFormat:@"%@",error.description] inView:self.view HideAfterDelay:1.0f];
            return ;
        }
        if ([response[@"status"] boolValue]) {
            [[CYProgressHUD sharedHUD]hideAfterDelay:0];
            [self dismissViewControllerAnimated:YES completion:^{
                [[CYProgressHUD sharedHUD]showText:@"注册成功" inView:self.view HideAfterDelay:1.0f];
            }];
        }else if ([response[@"code"] longValue] == 500){
            [[CYProgressHUD sharedHUD]hideAfterDelay:0];
            [[CYProgressHUD sharedHUD]showText:@"注册失败，请稍候再试" inView:self.view HideAfterDelay:1.0f];
        }
    }];
}
-(void)initTopUI{
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 240)];
    backgroundView.backgroundColor = LeftBlue;
    [self.view addSubview:backgroundView];
    
    UIView *logoBackground = [[UIView alloc]initWithFrame:CGRectMake(screenWidth /2 -50, 190, 100, 100)];
    logoBackground.backgroundColor = [UIColor whiteColor];
    logoBackground.layer.borderWidth = 2;
    logoBackground.layer.borderColor = LeftBlue.CGColor;
    [self.view addSubview:logoBackground];
//    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(screenWidth/2 -40, 200, 80, 80)];
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    logo.image = [UIImage imageNamed:@"base"];
    [logoBackground addSubview:logo];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 40, 20)];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:backButton];
    
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_logintext resignFirstResponder];
    [_Passwordtext resignFirstResponder];
    return YES;
}
@end
