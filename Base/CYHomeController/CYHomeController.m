//
//  CYHomeController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#import "CYHomeController.h"
#import "CYAllPeopleViewController.h"
#import "CYProjectViewController.h"
#import "CYDrawerView.h"
@interface CYHomeController ()
@property(nonatomic,strong) UISegmentedControl *segment; /**<  顶部切换*/
@property(nonatomic,strong) UIViewController *currentVC; /**<  当前页面*/
@property(nonatomic,strong) CYAllPeopleViewController *ALLPVC;
@property(nonatomic,strong) CYProjectViewController *ProVC;
@property(nonatomic,assign) CGFloat maxY;
@property(nonatomic,assign) CGFloat offsetLeft;
@property(nonatomic,strong) UIView *mainView;
@end

@implementation CYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxY = 0;
    self.offsetLeft = screenWidth * 0.82;
    [self initVC];
    [self initsegment];
    [self setupGesture];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO; //切到其他画面之后顶部不变
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化vc
-(void)initVC{
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.ALLPVC = [[CYAllPeopleViewController alloc]init];
    self.ProVC = [[CYProjectViewController alloc]init];
    self.currentVC = self.ProVC;
    CYDrawerView *leftView = [[CYDrawerView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftView];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.ProVC.view];
    
}
#pragma mark - 初始化segmentControl
- (void)initsegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"项目组",@"所有人"]];   //设置名字
    self.segment.frame = CGRectMake(screenWidth/2-100, 18,200, 33);
//    [self.segment setWidth:100 forSegmentAtIndex:0];                            //设置宽度
//    [self.segment setWidth:100 forSegmentAtIndex:1];
    self.segment.selectedSegmentIndex = 0;                              //设置初始位置
    [self.segment addTarget:self action:@selector(segmentdidChange:) forControlEvents:UIControlEventValueChanged];
    [self.mainView addSubview:self.segment];
}
#pragma mark -segment改变
- (void)segmentdidChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self segmentDidChangeFromOld:self.currentVC toNew:self.ProVC];
            [self.ProVC.view bringSubviewToFront:self.segment];
            break;
        case 1:
            [self segmentDidChangeFromOld:self.currentVC toNew:self.ALLPVC];
            [self.ALLPVC.view bringSubviewToFront:self.segment];
        default:
            break;
    }
}
#pragma mark -segment从旧VC到新VC
- (void)segmentDidChangeFromOld:(UIViewController *)OldVC toNew:(UIViewController *)NewVC{
    [self addChildViewController:NewVC];
    [self addChildViewController:OldVC];
    [self transitionFromViewController:OldVC toViewController:NewVC duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [NewVC didMoveToParentViewController:self];
            [OldVC willMoveToParentViewController:nil];
            [OldVC removeFromParentViewController];
            self.currentVC = NewVC;
        }else{
            self.currentVC = OldVC;
        }
    }];
}
#pragma mark - 简单抽屉手势
- (void) setupGesture{
    UIPanGestureRecognizer *PAN = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:PAN];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapGes)];
    
    [self.view addGestureRecognizer:tap];
}
- (void)tapGes{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint finger = [pan translationInView:self.mainView];
    if (finger.x <=0 ) {
        finger.x = 0;
    }
    self.mainView.frame = [self framewithoffsetX:finger.x];
    CGFloat target = 0 ;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x > screenWidth * 0.34) {
            target = self.offsetLeft ;
        }
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = [self framewithoffsetX:offsetX];
        }];
    }
    [pan setTranslation:CGPointZero inView:self.mainView];
    
}

-(CGRect)framewithoffsetX:(CGFloat)offsetX{
    CGRect frame = self.mainView.frame;
    frame.origin.x += offsetX;
    if (frame.origin.x >= screenWidth * 0.82) {
        frame.origin.x = screenWidth *0.82;
    }
    return frame;
}

-(UINavigationBar*)navigationBarContainedWithinSubview:(UIView *)view{
    UINavigationBar *navibar = nil;
    for (UIView *subview in [view subviews]) {
        if ([view isKindOfClass:[UINavigationBar class]]) {
            navibar = (UINavigationBar *)view;
            break;
        }else{
            navibar = [self navigationBarContainedWithinSubview:subview];
            if (navibar != nil) {
                break;
            }
        }
    }
    return navibar;
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
