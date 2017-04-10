//
//  CYDrawerView.m
//  Young Eagles
//
//  Created by NMID on 2017/3/27.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYDrawerView.h"
#import "CYHelper.h"
@implementation CYDrawerView
{
    BOOL homeFlag;
}
- (instancetype)init{
    if (self = [super init]) {
        homeFlag = YES;
        self.backgroundColor = LeftBlue;
        [self initTopUI];
        [self setupButton];
            }
    return self;
}
-(void)initTopUI{
    UIView *TopView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, LeftOffX, screenHeight / 3 -20)];
    UILabel *mail = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, LeftOffX, 40)];
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(130, 40, LeftOffX - 130, 120)];
    word.font = [UIFont fontWithName:@"Helvetica-Bold" size:17.f];
    word.numberOfLines = 3;
    mail.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.f];
    [mail setText:@"Nexuslink@nexuslink.cn"];
    [word setText:@"重邮\n\n移动互联网研究中心"];
    TopView.backgroundColor = [UIColor whiteColor];
    UIImageView *IconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"base"]];
    IconImage.frame = CGRectMake(30, 60, 80, 80);
    
    [self addSubview:TopView];
    [TopView addSubview:mail];
    [TopView addSubview:IconImage];
    [TopView addSubview:word];
}
-(void) setupButton{
    UIButton  *projName = [self setButtonwithTitle:@"通讯录" forState:UIControlStateNormal andLocation:(screenHeight / 3) andImage:@"Commercial Development Management-50"];
    [projName addTarget:self action:@selector(tapFirstBtn) forControlEvents:UIControlEventTouchUpInside];
    UIButton  *experts = [self setButtonwithTitle:@"管理手册" forState:UIControlStateNormal andLocation:(screenHeight / 3 + 45) andImage:@"Literature-64"];
    [experts addTarget:self action:@selector(tapSecondBtn) forControlEvents:UIControlEventTouchUpInside];
    UIButton  *book = [self setButtonwithTitle:@"专家" forState:UIControlStateNormal andLocation:(screenHeight / 3 + 90) andImage:@"Contacts-50"];
    [book addTarget:self action:@selector(tapThirdBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:projName];
    [self addSubview:experts];
    [self addSubview:book];

}

- (UIButton *)setButtonwithTitle:(NSString *)Title forState:(UIControlState *)UIControlState andLocation:(CGFloat )y andImage:(NSString *)ImageName{
    UIButton *Btn = [[UIButton alloc]initWithFrame:CGRectMake(60, y, 150, 40)];
    [Btn setTitle:Title forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:18];
    Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
   // Btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ImageName]];
    image.frame = CGRectMake(-40, 5, 30, 30);
    [Btn addSubview:image];
    return Btn;
}
-(void)tapFirstBtn{
    if (!homeFlag) {
    self.change = @"0";
    NSDictionary *NotiDic = @{@"1":@"通讯录",
                                  @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        NSLog(@"点第一个按钮,change值为%@",self.change);
    }

}
-(void)tapSecondBtn{
    self.change =@"1";
    homeFlag = NO;
    NSDictionary *NotiDic = @{@"1":@"管理手册",
                              @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    NSLog(@"点第二个按钮,change值为%@",self.change);
}
-(void)tapThirdBtn{
    self.change =@"2";
    homeFlag = NO;
    NSDictionary *NotiDic = @{@"1":@"专家",
                              @"2":self.change};
    NSNotification *notice = [NSNotification notificationWithName:@"changeView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    NSLog(@"点第三个按钮,change值为%@",self.change);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
