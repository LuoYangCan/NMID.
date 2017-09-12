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
#import "CYDetailProjectViewController.h"
#import "CYPersonView.h"
#import "CYProgressHUD.h"
#import "CYNetwork.h"

@interface CYContactViewController ()
@property(nonatomic,strong) CYProjectView *PV;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) UISegmentedControl *segment;
@property (nonatomic,strong) NSArray *infoArray;        /**< 获取到的个人信息  */
@property (nonatomic,strong) NSDictionary *infoDic;        /**< 信息字典  */
@end

@implementation CYContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}
-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray =[NSArray array];
    }
    return _infoArray;
}

-(NSDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [[NSDictionary alloc]init];
    }
    return _infoDic;
}

-(CYProjectView *)PV{
    if (!_PV) {
        _PV =[[CYProjectView alloc]initWithDic:self.infoDic];
    }
    return _PV;
}

-(CYAllPeopleView *)ALLV{
    if (!_ALLV) {
        _ALLV = [[CYAllPeopleView alloc]initWithArray:self.infoArray];
    }
    return _ALLV;
}

-(void)setup{
    [self getDatawithCompletionBlock:^(NSError *error) {
        if (!error) {
            [self initUI];
            [self initNotification];
            [self initsegment];
        }else{
            [[CYProgressHUD sharedHUD]showText:error.description inView:self.view HideAfterDelay:1.0f];
        }
    }];

}

-(void)getDatawithCompletionBlock:(void (^) (NSError * error))Completionblock{
    [[CYNetwork sharedManager]get_ReuqestwithURLParameters:@"/getUserList" completion:^(NSError * error, id response, NSURLSessionTask * task) {
        if (Completionblock) {
            if (error) {
                Completionblock(error);
            }else{
                self.infoArray = response;
                self.infoDic = response;
                Completionblock(nil);
            }
        }
    }];
}
-(void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ALLV];
    [self.view addSubview:self.PV];
}

-(void)initNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(pushViewController:) name:PUSH_VIEW object:nil];
    [center addObserver:self selector:@selector(pushDetail:) name:PUSH_DTAIL object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PUSH_VIEW object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PUSH_DTAIL object:nil];
    
}

-(void)pushDetail:(NSNotification *)sender {
    NSDictionary *dic = sender.userInfo;
    CYPersonView *pView = [[CYPersonView alloc]initwithPersonInfoDic:dic];
    [self presentViewController:pView animated:YES completion:nil];
    
}
- (void)pushViewController:(NSNotification *)sender{
    NSArray *projectMember = [sender.userInfo objectForKey:@"1"];
    NSString *projectName = [sender.userInfo objectForKey:@"2"];
    CYDetailProjectViewController *detailPVC = [[CYDetailProjectViewController alloc]initWithProjectInfo:projectMember];
    detailPVC.title = projectName;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailPVC animated:YES];
    
    
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
