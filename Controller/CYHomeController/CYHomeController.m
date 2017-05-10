//
//  CYHomeController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYHomeController.h"
#import "CYAllPeopleView.h"
#import "CYDetailProjectViewController.h"
#import "CYProjectView.h"
#import "CYExpertsViewController.h"
#import "CYManagerViewController.h"
#import "CYHomeView.h"
#import "CYLoginViewController.h"
#import "CYContactViewController.h"
@interface CYHomeController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UISegmentedControl *segment; /**<  顶部切换*/
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) CYProjectView *PV;
@property(nonatomic,strong) CYManagerViewController *ManaV;
@property(nonatomic,strong) CYExpertsViewController *ExpertsV;
@property(nonatomic,strong) CALayer *imageLayer;
@property(nonatomic,strong) UIButton *LeftBtn;
@property(nonatomic,strong) CYHomeView *HomeView;
@property(nonatomic,strong) CYContactViewController *ContactView;
@property(nonatomic,strong) UITabBarController *HomeTabbar;
@property(nonatomic,assign) int Childcount;
@end

@implementation CYHomeController
{
    BOOL flag ;
    CGFloat maxY;
    CGFloat offsetLeft;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.Childcount = 1;
     maxY = 0;
    offsetLeft = LeftOffX;
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup{
    [self initVC];
    [self initNotification];
    [self initKVO];
  //  [self setupGesture];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushView" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeView" object:nil];
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:@"showLeft" object:nil];
    [self removeObserver:self forKeyPath:@"Childcount" context:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.Childcount = 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [center addObserver:self selector:@selector(pushViewController:) name:@"pushView" object:nil];
  //  [center addObserver:self selector:@selector(showLeftView) name:@"showLeft" object:nil];

}

- (void)pushViewController:(NSNotification *)sender{
    NSArray *projectMember = [sender.userInfo objectForKey:@"1"];
    NSString *projectName = [sender.userInfo objectForKey:@"2"];
    CYDetailProjectViewController *detailPVC = [[CYDetailProjectViewController alloc]initWithProjectInfo:projectMember];
    detailPVC.title = projectName;
    [self.navigationController pushViewController:detailPVC animated:YES];
    

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
    [self.navigationController pushViewController:_ContactView animated:YES];
}

-(void)showManaV{
    _ManaV = [[CYManagerViewController alloc]init];
    NSNotification *notice = [NSNotification notificationWithName:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
        self.Childcount += 1;
    [self.navigationController pushViewController:_ManaV animated:YES];
}
-(void)showExpertsV{
    _ExpertsV = [[CYExpertsViewController alloc]init];
    NSNotification *notice = [NSNotification notificationWithName:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
        self.Childcount += 1;
    [self.navigationController pushViewController:_ExpertsV animated:YES];
}

-(CGRect)framemove{
    CGRect frame = self.view.frame;
    frame.origin.x += screenWidth;
    return frame;
}

#pragma mark - 初始化vc
-(void)initVC{
    //顶部左侧按钮
//    self.LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 29, 30, 30)];
//    [self.LeftBtn setImage:[UIImage imageNamed:@"Menu-40"] forState:UIControlStateNormal];
//    [self.LeftBtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    //主界面初始化
    self.mainView = [[UIView alloc]initWithFrame:wholeScreen];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mainView.layer.shadowOpacity = 0.8f;
    self.mainView.layer.shadowRadius = 4.f;
    self.mainView.layer.shadowOffset = CGSizeMake(0, 0);
    self.mainView.backgroundColor = [UIColor whiteColor];
    //主页初始化
    self.HomeView = [[CYHomeView alloc]init];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.HomeView];

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
