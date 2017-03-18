//
//  CYHomeController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYHomeController.h"
#import "CYAllPeopleViewController.h"
#import "CYProjectViewController.h"

@interface CYHomeController ()
@property(nonatomic,strong) UISegmentedControl *segment; /**<  顶部切换*/
@property(nonatomic,strong) UIViewController *currentVC; /**<  当前页面*/
@property(nonatomic,strong) CYAllPeopleViewController *ALLPVC;
@property(nonatomic,strong) CYProjectViewController *ProVC;
@end

@implementation CYHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initVC];
    [self initsegment];
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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.ALLPVC = [[CYAllPeopleViewController alloc]init];
    self.ProVC = [[CYProjectViewController alloc]init];
    self.currentVC = self.ProVC;
    [self.view addSubview:self.ProVC.view];
    
}
#pragma mark - 初始化segmentControl
- (void)initsegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"项目组",@"所有人"]];   //设置名字
    [self.segment setWidth:100 forSegmentAtIndex:0];                            //设置宽度
    [self.segment setWidth:100 forSegmentAtIndex:1];
    self.segment.selectedSegmentIndex = 0;                              //设置初始位置
    [self.segment addTarget:self action:@selector(segmentdidChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
    
}
#pragma mark -segment改变
- (void)segmentdidChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self segmentDidChangeFromOld:self.currentVC toNew:self.ProVC];
            break;
        case 1:
            [self segmentDidChangeFromOld:self.currentVC toNew:self.ALLPVC];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
