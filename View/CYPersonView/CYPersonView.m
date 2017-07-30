//
//  CYPersonView.m
//  雏鹰计划
//
//  Created by 孤岛 on 2017/7/13.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYPersonView.h"
#import "CYHelper.h"
@interface CYPersonView ()

@end

@implementation CYPersonView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setup{
    [self initUI];
}
-(instancetype)initwithPersonInfoDic:(NSDictionary *)dic{
    if (self == [super init]) {
        [self setup];
        
        
    }
    return self;
}


-(void)initUI{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    //名字
    UILabel *Name = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth - 140, 80, 120, 40)];
    Name.text = @"罗阳灿";
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
    [pDetail setText:@"iOS开发"];
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
    [phone setText:@"13983168636"];
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
    [mymail setText:@"luo.yangcan@foxmail.cn"];
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
    [QQnumber setText:@"584487926"];
    [QQnumber setFont:[UIFont systemFontOfSize:22]];
    [self.view addSubview:QQnumber];
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
