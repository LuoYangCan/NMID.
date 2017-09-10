//
//  CYPersonView.m
//  雏鹰计划
//
//  Created by 孤岛 on 2017/7/13.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYPersonView.h"
#import "CYHelper.h"
#import "CYNetwork.h"
#import "CYProgressHUD.h"

@interface CYPersonView ()
@property (nonatomic,strong) NSDictionary *UserInfo;        /**< 用户信息  */

@end

@implementation CYPersonView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSDictionary *)UserInfo {
    if (!_UserInfo) {
        _UserInfo = [[NSDictionary alloc]init];
    }
    return _UserInfo;
}
-(void)setup{
    [self initbackBtn];
 [[CYNetwork sharedManager]get_ReuqestwithURLParameters:@"/getUser/userId" completion:^(NSError * error, id response, NSURLSessionTask * task) {
     if (error) {
         [[CYProgressHUD sharedHUD]showText:error.description inView:self.view HideAfterDelay:1.0f];
     }else if(!error){
         self.UserInfo = response;
         [self setup];
     }
 }];
}
-(instancetype)initwithPersonInfoDic:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setup];
    }
    return self;
}
-(void)initbackBtn{
    UIButton *backbtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 32, 60, 30)];
    [backbtn setTitle:@"返回" forState:UIControlStateNormal];
    [backbtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbtn];
}


-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initUI{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    //名字
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 140, 80, 120, 40)];
    Name.text = self.UserInfo[@"userName"];
    [Name setFont:[UIFont fontWithName:@"Helvetica-Bold" size:34]];
    Name.textColor = [UIColor grayColor];
    [self.view addSubview:Name];
    //图
    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(35, 35, 90, 90)];
    [logo setImage:[UIImage imageNamed:@"base"]];
    [self.view addSubview:logo];

    //线
    UILabel *lin1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 160, screenWidth-15, 1)];
    lin1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:lin1];
    
    //职位
    UILabel *position = [[UILabel alloc]initWithFrame:CGRectMake(35, 174.5, 40, 20)];
    position.text = @"职责";
    [position setTextColor:[UIColor grayColor]];
    [position setFont:[UIFont boldSystemFontOfSize:19]];
    [self.view addSubview:position];
    
    //职位详情
    UILabel *pDetail = [[UILabel alloc]initWithFrame:CGRectMake(35, 198, 120, 30)];
    [pDetail setText:self.UserInfo[@"job"]];
    [pDetail setFont:[UIFont systemFontOfSize:24]];
    [self.view addSubview:pDetail];
    
    //联系方式
    UILabel *contact = [[UILabel alloc]initWithFrame:CGRectMake(35, 296, 80, 20)];
    [contact setText:@"联系方式"];
    [contact setTextColor:[UIColor grayColor]];
    [contact setFont:[UIFont boldSystemFontOfSize:19]] ;
    [self.view addSubview:contact];
    
    //电话
    UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(35, 324, 160, 20)];
    [phone setText:self.UserInfo[@"tel"]];
    [phone setFont:[UIFont systemFontOfSize:24]];
    [self.view addSubview:phone];
    
    //邮件
    UILabel *mail = [[UILabel alloc]initWithFrame:CGRectMake(35, 398, 80, 20)];
    [mail setText:@"邮箱"];
    [mail setTextColor:[UIColor grayColor]];
    [mail setFont:[UIFont boldSystemFontOfSize:19]];
    [self.view addSubview:mail];

    //邮箱
    UILabel *mymail = [[UILabel alloc]initWithFrame:CGRectMake(35, 418,screenWidth - 35, 30)];
    [mymail setText:self.UserInfo[@"eMail"]];
    [mymail setFont:[UIFont systemFontOfSize:22]];
    [self.view addSubview:mymail];
    
    //QQ
    UILabel *QQ =[[UILabel alloc]initWithFrame:CGRectMake(35, 500, 80, 20)];
    [QQ setText:@"QQ"];
    [QQ setTextColor:[UIColor grayColor]];
    [QQ setFont:[UIFont boldSystemFontOfSize:19]];
    [self.view addSubview:QQ];
    
    //QQ号码
    UILabel *QQnumber = [[UILabel alloc]initWithFrame:CGRectMake(35, 530, 150, 20)];
    [QQnumber setText:self.UserInfo[@"qqNum"]];
    [QQnumber setFont:[UIFont systemFontOfSize:22]];
    [self.view addSubview:QQnumber];
}

@end
