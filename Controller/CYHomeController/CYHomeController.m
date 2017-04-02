//
//  CYHomeController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYHomeController.h"
#import "CYDrawerView.h"
#import "CYAllPeopleView.h"
#import "CYDetailProjectViewController.h"
#import "CYProjectView.h"
@interface CYHomeController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UISegmentedControl *segment; /**<  顶部切换*/
@property(nonatomic,strong) UIViewController *currentVC; /**<  当前页面*/
@property(nonatomic,assign) CGFloat maxY;
@property(nonatomic,assign) CGFloat offsetLeft;
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) CYProjectView *PV;
@end

@implementation CYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushViewController:) name:@"pushView" object:nil];
    self.maxY = 0;
    self.offsetLeft = screenWidth * 0.81;
    [self initVC];
    [self initsegment];
    [self setupGesture];
   // self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(NSNotification *)sender{
    NSArray *projectMember = [sender.userInfo objectForKey:@"1"];
    NSString *projectName = [sender.userInfo objectForKey:@"2"];
    CYDetailProjectViewController *detailPVC = [[CYDetailProjectViewController alloc]initWithProjectInfo:projectMember];
    UINavigationController *navic = [[UINavigationController alloc]initWithRootViewController:detailPVC];
    detailPVC.navigationItem.title = projectName;
    [self presentViewController:navic animated:YES completion:^{
        NSLog(@"转移成功!\n");
        NSLog(@"项目名字:%@",projectName);
    }];

}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushView" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = NO; //切到其他画面之后顶部不变
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化vc
-(void)initVC{
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.PV = [[CYProjectView alloc]init];
    //self.currentVC = self.ProVC;
    CYDrawerView *leftView = [[CYDrawerView alloc]initWithFrame:self.view.bounds];
    leftView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:leftView];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.PV];
   // [self.mainView addSubview:self.ProVC.view];
    self.ALLV = [[CYAllPeopleView alloc]init];
    
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
           // [self segmentDidChangeFromOld:self.currentVC toNew:self.ProVC];
            [self.ALLV removeFromSuperview];
            break;
        case 1:
            self.ALLV.frame = CGRectMake(0, 65, screenWidth, screenHeight);
            [self.mainView addSubview:self.ALLV];
//            self.ALLPVC.view.frame = CGRectMake(0, 65, screenWidth, screenHeight);
//            [self.mainView addSubview:self.ALLPVC.view];
            
          //  [self segmentDidChangeFromOld:self.currentVC toNew:self.ALLPVC];
        default:
            break;
    }
}
//#pragma mark -segment从旧VC到新VC
//- (void)segmentDidChangeFromOld:(UIViewController *)OldVC toNew:(UIViewController *)NewVC{
//    [self addChildViewController:NewVC];
//    [self addChildViewController:OldVC];
//    [self transitionFromViewController:OldVC toViewController:NewVC duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
//        if (finished) {
//            [NewVC didMoveToParentViewController:self];
//            [OldVC willMoveToParentViewController:nil];
//            [OldVC removeFromParentViewController];
//            self.currentVC = NewVC;
//        }else{
//            self.currentVC = OldVC;
//        }
//    }];
//}
#pragma mark - 简单抽屉手势
- (void) setupGesture{
    
    UIPanGestureRecognizer *PAN = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:PAN];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapGes)];
    tap.delegate = self;
    
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
    if (frame.origin.x >= screenWidth * 0.81) {
        frame.origin.x = screenWidth *0.81;
    }
    return frame;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.mainView.frame.origin.x > 0) {
        return YES;
    }else{
        return NO;
    }
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
