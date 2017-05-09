//
//  CYContactViewController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/9.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYProjectView.h"
#import "CYAllPeopleView.h"
#import "CYContactViewController.h"

@interface CYContactViewController ()
@property(nonatomic,strong) CYProjectView *PV;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) UISegmentedControl *segment;
@end

@implementation CYContactViewController

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
    [self initUI];
    [self initsegment];
}
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.PV = [[CYProjectView alloc]init];
    self.ALLV = [[CYAllPeopleView alloc]init];
    [self.view addSubview:self.ALLV];
    [self.view addSubview:self.PV];
}


#pragma mark - 初始化segmentControl
- (void)initsegment{
    self.segment = [[UISegmentedControl alloc]initWithItems:@[@"项目组",@"所有人"]];   //设置名字
    self.segment.frame = CGRectMake(screenWidth/2-100, 27,200, 33);
    self.segment.selectedSegmentIndex = 0;                              //设置初始位置
    [self.segment addTarget:self action:@selector(segmentdidChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segment;
}
#pragma mark -segment改变
- (void)segmentdidChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.view bringSubviewToFront:_PV];
            break;
        case 1:
            [self.view bringSubviewToFront:_ALLV];
        default:
            break;
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
