//
//  CYDiscussViewController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/15.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYDiscussViewController.h"
#import "CYExpertsViewController.h"
#import "CYContactViewController.h"
#import "CYManagerViewController.h"
#import "CYDetailProjectViewController.h"
@interface CYDiscussViewController ()
@property(nonatomic,assign) int Childcount;
@property(nonatomic,strong) CYContactViewController *ContactView;
@property(nonatomic,strong) CYManagerViewController *ManaV;
@property(nonatomic,strong) CYExpertsViewController *ExpertsV;
@end

@implementation CYDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"pushView" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeView" object:nil];
    [self removeObserver:self forKeyPath:@"Childcount" context:nil];
    
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
