//
//  CYDrawViewController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/9.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYDrawViewController.h"
#import "CYHelper.h"
@interface CYDrawViewController ()
@property (nonatomic,strong) NSString *change;
@end

@implementation CYDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setup{
    [self initTopUI];
    [self setupButton];
}
-(void)initTopUI{
    self.view.backgroundColor = LeftBlue;
    UIView *TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LeftOffX, screenHeight / 3 -20)];
    TopView.backgroundColor = [UIColor whiteColor];
    UILabel *mail = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, LeftOffX, 40)];
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, LeftOffX - 130, 120)];
    word.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    word.numberOfLines = 3;
    mail.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    [mail setText:@"Nexuslink@nexuslink.cn"];
    [word setText:@"重邮\n\n移动互联网研究中心"];
    UIImageView *IconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base"]];
    IconImage.frame = CGRectMake(30, 60, 80, 80);
    
    [self.view addSubview:TopView];
    [TopView addSubview:mail];
    [TopView addSubview:IconImage];
    [TopView addSubview:word];
}
-(void) setupButton{
    UIButton  *projName = [self setButtonwithTitle:@"        通讯录" forState:UIControlStateNormal andLocation:(screenHeight / 3) andImage:@"Commercial Development Management-50"];
    [projName addTarget:self action:@selector(tapFirstBtn) forControlEvents:UIControlEventTouchUpInside];
    UIButton  *experts = [self setButtonwithTitle:@"        文件管理" forState:UIControlStateNormal andLocation:(screenHeight / 3 + 45) andImage:@"Literature-64"];
    [experts addTarget:self action:@selector(tapSecondBtn) forControlEvents:UIControlEventTouchUpInside];
    UIButton  *book = [self setButtonwithTitle:@"        专家" forState:UIControlStateNormal andLocation:(screenHeight / 3 + 90) andImage:@"Contacts-50"];
    [book addTarget:self action:@selector(tapThirdBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:projName];
    [self.view addSubview:experts];
    [self.view addSubview:book];
    
}

- (UIButton *)setButtonwithTitle:(NSString *)Title forState:(UIControlState *)UIControlState andLocation:(CGFloat )y andImage:(NSString *)ImageName{
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(20, y, LeftOffX -50, 40)];
    [Btn setTitle:Title forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ImageName]];
    image.frame = CGRectMake(0, 4, 30, 30);
    [Btn addSubview:image];
    return Btn;
}
-(void)tapFirstBtn{
    self.change = @"0";
    NSDictionary *NotiDic = @{@"1":@"通讯录",
                              @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
}
-(void)tapSecondBtn{
    self.change =@"1";
    NSDictionary *NotiDic = @{@"1":@"文件管理",
                              @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
}
-(void)tapThirdBtn{
    self.change =@"2";
    NSDictionary *NotiDic = @{@"1":@"专家",
                              @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
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
