//
//  CYUserInfoViewController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/15.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYUserInfoViewController.h"
#import "CYHelper.h"
#import "CYContactViewController.h"
#import "CYExpertsViewController.h"
#import "CYManagerViewController.h"
#import "CYDetailProjectViewController.h"
@interface CYUserInfoViewController ()
@property(nonatomic,strong)UIImage *HeadImage;
@property(nonatomic,strong)UILabel *Username;
@property(nonatomic,strong)UILabel *UserProject;
@property(nonatomic,assign) int Childcount;
@property(nonatomic,strong) CYContactViewController *ContactView;
@property(nonatomic,strong) CYManagerViewController *ManaV;
@property(nonatomic,strong) CYExpertsViewController *ExpertsV;
@end

@implementation CYUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initKVO];
    [self initNotification];
    self.Childcount = 1;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeView" object:nil];
    [self removeObserver:self forKeyPath:@"Childcount" context:nil];

}

-(void)initUI{
    self.view.backgroundColor = kBackgroundGray;
    UIView *Top = [[UIView alloc]initWithFrame:CGRectMake(0, 80, screenWidth, 100)];
    Top.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:Top];
    
    _HeadImage = [UIImage imageNamed:@"Commercial Development Management-50"];
    UIImageView *HeadIcon = [[UIImageView alloc]initWithImage:_HeadImage];
    HeadIcon.frame = CGRectMake(30, 15, 70, 70);
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:HeadIcon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:HeadIcon.bounds.size];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
    masklayer.frame = HeadIcon.bounds;
    masklayer.path = maskPath.CGPath;
    HeadIcon.layer.mask = masklayer;
    [Top addSubview:HeadIcon];
    
    _Username = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /2-68, 15, 120, 25)];
    _Username.text = @"Reus97";
    _Username.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
    [Top addSubview:_Username];
    
    _UserProject = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth/2-68, 40, 200, 30)];
    _UserProject.font =[UIFont fontWithName:@"Helvetica" size:14];
    _UserProject.text = @"智能互联机场导航小车";
    [Top addSubview:_UserProject];
    
    
}
#pragma mark - kvo
-(void)initKVO{
    [self addObserver:self forKeyPath:@"Childcount" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"Childcount"]) {
        NSString *str =[change valueForKey:@"new"];
        if ([str intValue] == 2) {
            NSNotification *notice = [NSNotification notificationWithName:@"Panoff" object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }else{
            NSNotification *notice = [NSNotification notificationWithName:@"Panon" object:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            
        }
    }
}
#pragma mark -通知
-(void)initNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(changeView:) name:@"changeView" object:nil];
}



-(void)changeView:(NSNotification *)sender{
    NSString *re = [sender.userInfo objectForKey:@"2"];
    switch ([re intValue]) {
        case 0:
            [self movetoHomeView];
            break;
        case 1:
            [self showManaV];
            break;
        case 2:
            [self showExpertsV];
            break;
        default:
            break;
    }
}

#pragma mark - 切换页面
-(void)movetoHomeView{
    _ContactView = [[CYContactViewController alloc]init];
    NSNotification *notice = [NSNotification notificationWithName:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    self.Childcount += 1;
    NSLog(@"%d",_Childcount );
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:_ContactView animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

-(void)showManaV{
    _ManaV = [[CYManagerViewController alloc]init];
    NSNotification *notice = [NSNotification notificationWithName:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    self.Childcount += 1;
    self.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:_ManaV animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}
-(void)showExpertsV{
    _ExpertsV = [[CYExpertsViewController alloc]init];
    NSNotification *notice = [NSNotification notificationWithName:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    self.Childcount += 1;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_ExpertsV animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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
