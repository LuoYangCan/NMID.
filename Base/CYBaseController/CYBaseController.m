//
//  CYBaseController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/8.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYBaseTabbarController.h"
#import "CYBaseController.h"
#import "CYDrawViewController.h"
#import "CYHelper.h"
@interface CYBaseController ()<UIGestureRecognizerDelegate>
@property(strong,nonatomic) CYBaseTabbarController *Tabbar;
@property(strong,nonatomic) CYDrawViewController *LeftView;
@property(strong,nonatomic) UIPanGestureRecognizer *PAN;
@end

@implementation CYBaseController
{
   CGFloat offsetLeft;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    offsetLeft = LeftOffX;
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setup{
    [self initLeftView];
    [self initTabbar];
    [self initGesture];
    [self initNotification];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"recycle" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Panoff" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Panon" object:nil];
}
-(void)initNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(recycleDrawer) name:@"recycle" object:nil];
    [center addObserver:self selector:@selector(Panoff) name:@"Panoff" object:nil];
    [center addObserver:self selector:@selector(Panon) name:@"Panon" object:nil];
}
-(void)Panoff{
    [_Tabbar.view removeGestureRecognizer:_PAN];
}
-(void)Panon{
    [_Tabbar.view addGestureRecognizer:_PAN];
}
-(void)initTabbar{
    _Tabbar = [[CYBaseTabbarController alloc]init];
    _Tabbar.view.backgroundColor = [UIColor whiteColor];
    _Tabbar.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _Tabbar.view.layer.shadowOpacity = 0.8f;
    _Tabbar.view.layer.shadowRadius = 4.f;
    _Tabbar.view.layer.shadowOffset = CGSizeMake(0,0);
    [self addChildViewController:_Tabbar];
    [self.view addSubview:_Tabbar.view];
}

-(void)initLeftView{
    _LeftView = [[CYDrawViewController alloc]init];
    _LeftView.view.frame = CGRectMake(0, 0, LeftOffX, screenHeight);
    [self addChildViewController:_LeftView];
    [self.view addSubview:_LeftView.view];
}

#pragma mark - 通知
-(void)recycleDrawer{
    [UIView animateWithDuration:0.25 animations:^{
        _Tabbar.view.frame = self.view.frame;
    }];
}

#pragma mark - 简单抽屉手势
- (void) initGesture{
    _PAN = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [_Tabbar.view addGestureRecognizer:_PAN];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapGes)];
    tap.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [_Tabbar.view addGestureRecognizer:tap];
}
- (void)tapGes{
    [UIView animateWithDuration:0.25 animations:^{
        _Tabbar.view.frame = self.view.bounds;
    }];
}
-(void)showLeftView{
    if (_Tabbar.view.frame.origin.x == screenWidth *0.81) {
        [UIView animateWithDuration:0.25 animations:^{
            _Tabbar.view.frame = self.view.bounds;
        }];
    }else{
    [UIView animateWithDuration:0.25 animations:^{
        _Tabbar.view.frame = [self framewithoffsetX:offsetLeft];
    }];
    }
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint finger = [pan translationInView:_Tabbar.view];
    if (finger.x <=0 && _Tabbar.view.frame.origin.x == 0) {
        finger.x = 0;
    }
    _Tabbar.view.frame = [self framewithoffsetX:finger.x];
    CGFloat target = 0 ;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (_Tabbar.view.frame.origin.x > screenWidth * 0.34) {
            target = offsetLeft ;
        }
        CGFloat offsetX = target - _Tabbar.view.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            _Tabbar.view.frame = [self framewithoffsetX:offsetX];
        }];
    }
    [pan setTranslation:CGPointZero inView:_Tabbar.view];

}

-(CGRect)framewithoffsetX:(CGFloat)offsetX{
    CGRect frame = _Tabbar.view.frame;
    frame.origin.x += offsetX;
    if (frame.origin.x >= LeftOffX) {
        frame.origin.x = LeftOffX;
    }else if (frame.origin.x <= 0){
        frame.origin.x = 0;
    }
    return frame;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (_Tabbar.view.frame.origin.x > 0) {
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
