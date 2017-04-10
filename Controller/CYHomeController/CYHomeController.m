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
#import "CYExpertsView.h"
#import "CYManagerView.h"
@interface CYHomeController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UISegmentedControl *segment; /**<  顶部切换*/
@property(nonatomic,strong) UIViewController *currentVC; /**<  当前页面*/
@property(nonatomic,strong) UIView *mainView;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) CYProjectView *PV;
@property(nonatomic,strong) CYManagerView *ManaV;
@property(nonatomic,strong) CYExpertsView *ExpertsV;
@property(nonatomic,strong) CYDrawerView *leftView;
@property(nonatomic,strong) CALayer *imageLayer;
@property(nonatomic,strong) UIButton *LeftBtn;
@end

@implementation CYHomeController
{
    BOOL flag ;
    CGFloat maxY;
    CGFloat offsetLeft;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushViewController:) name:@"pushView" object:nil];
    [center addObserver:self selector:@selector(changeView:) name:@"changeView" object:nil];
     maxY = 0;
    offsetLeft = LeftOffX;
    [self performSelector:@selector(setup) withObject:nil afterDelay:3];

   // self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (flag == NO) {
        [self showImage];
        flag = YES;
    }

}
- (void)setup{
    [self initVC];
    [self initsegment];
    [self setupGesture];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushView" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeView" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -通知
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
-(void)changeView:(NSNotification *)sender{
    NSString *re = [sender.userInfo objectForKey:@"2"];
    NSLog(@"收到的回复是%@",re);
    switch ([re intValue]) {
        case 0:
            [self.ExpertsV removeFromSuperview];
            [self.ManaV removeFromSuperview];
            break;
        case 1:
            [self.ManaV removeFromSuperview];
            [self.ExpertsV removeFromSuperview];
            self.ManaV = [[CYManagerView alloc]init];
            self.ManaV.frame = self.mainView.bounds;
            [self.mainView addSubview:self.ManaV];
            [self.mainView bringSubviewToFront:self.ManaV];
            break;
        case 2:
            [self.ExpertsV removeFromSuperview];
            [self.ManaV removeFromSuperview];
            self.ExpertsV = [[CYExpertsView alloc]init];
            self.ExpertsV.frame = self.mainView.bounds;
            [self.mainView addSubview:self.ExpertsV];
            [self.mainView bringSubviewToFront:self.ExpertsV];
            break;
        default:
            break;
    }
}

#pragma mark - 初始化vc
-(void)initVC{
    self.LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 29, 30, 30)];
    [self.LeftBtn setImage:[UIImage imageNamed:@"Menu-40"] forState:UIControlStateNormal];
    [self.LeftBtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.PV = [[CYProjectView alloc]init];
    self.leftView = [[CYDrawerView alloc]init];
    self.leftView.frame = self.view.bounds;
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.PV];
    [self.mainView addSubview:self.LeftBtn];
    self.ALLV = [[CYAllPeopleView alloc]init];
    
}
#pragma mark - 初始化segmentControl
- (void)initsegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"项目组",@"所有人"]];   //设置名字
    self.segment.frame = CGRectMake(screenWidth/2-100, 27,200, 33);
    self.segment.selectedSegmentIndex = 0;                              //设置初始位置
    [self.segment addTarget:self action:@selector(segmentdidChange:) forControlEvents:UIControlEventValueChanged];
    [self.mainView addSubview:self.segment];
    
}
#pragma mark -segment改变
- (void)segmentdidChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.ALLV removeFromSuperview];
            break;
        case 1:
            self.ALLV.frame = CGRectMake(0, 65, screenWidth, screenHeight);
            [self.mainView addSubview:self.ALLV];
        default:
            break;
    }
}

#pragma mark - 简单抽屉手势
- (void) setupGesture{
    
    UIPanGestureRecognizer *PAN = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:PAN];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapGes)];
    tap.delegate = self;
    
    [self.mainView addGestureRecognizer:tap];
}
- (void)tapGes{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}
-(void)showLeftView{
    if (self.mainView.frame.origin.x == screenWidth *0.81) {
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = self.view.bounds;
        }];
    }else{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = [self framewithoffsetX:offsetLeft];
    }];
    }
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
            target = offsetLeft ;
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
    if (frame.origin.x >= LeftOffX) {
        frame.origin.x = LeftOffX;
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
#pragma mark - 载入界面
- (void) showImage{
    UIImage *background = [UIImage imageNamed:@"background"];
    
    self.imageLayer = [CALayer layer];
    self.imageLayer.frame = CGRectMake(0, 0, screenWidth, screenHeight);
    [self.view.layer addSublayer:self.imageLayer];
    self.imageLayer.contents = (__bridge id)(background.CGImage);
    
    [self performSelector:@selector(layerAnimation) withObject:nil afterDelay:1.0f];
    
    
}

-(void)layerAnimation{
    UIImage *LaunchImage = [UIImage imageNamed:@"Launch_Image"];
    
    CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
    contentsAnimation.fromValue = self.imageLayer.contents;
    contentsAnimation.toValue = (__bridge id)(LaunchImage.CGImage);
    contentsAnimation.duration = 2;
    
    self.imageLayer.contents = (__bridge id)(LaunchImage.CGImage);
    [self.imageLayer addAnimation:contentsAnimation forKey:nil];
    [self.imageLayer performSelector:@selector(removeFromSuperlayer) withObject:nil afterDelay:2.7f];
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
