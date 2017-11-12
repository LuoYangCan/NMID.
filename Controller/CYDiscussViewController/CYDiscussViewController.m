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
#import "CYHelper.h"
#import "CYNetwork.h"
#import "CYProgressHUD.h"
#import "CYHomeTableCell.h"

@interface CYDiscussViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,assign) int Childcount;
@property(nonatomic,strong) CYContactViewController *ContactView;
@property(nonatomic,strong) CYManagerViewController *ManaV;
@property(nonatomic,strong) CYExpertsViewController *ExpertsV;
@property(nonatomic,strong) UITableView *baseTableView;   /**< 讨论  */
@property(nonatomic,strong) NSArray *infoArray;   /**< 信息字典  */
@end

@implementation CYDiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNetwork];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = [NSArray array];
    }
    return _infoArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initKVO];
    [self initNotification];
    self.Childcount = 1;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:PUSH_VIEW object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:CHANGE_VIEW object:nil];
    [self removeObserver:self forKeyPath:@"Childcount" context:nil];
    
}




-(void)initTableView{
    self.baseTableView = [[UITableView alloc]initWithFrame:wholeScreen];
    self.baseTableView.delegate= self;
    self.baseTableView.dataSource =self;
}

-(void)initNetwork{
    [[CYNetwork sharedManager]get_ReuqestwithURLParameters:@"/getMomentList" completion:^(NSError *error, id response, NSURLSessionTask * task) {
        if (error) {
            [[CYProgressHUD sharedHUD]showText:error.description inView:self.view HideAfterDelay:1.0f];
        }else{
            self.infoArray = response;
        }
    }];
}







#pragma mark -UITableViewDelegate && UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.infoArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscussCell"];
    if (!cell) {
        cell = [[CYHomeTableCell alloc]init];
    }
    NSDictionary *dic = self.infoArray[indexPath.row];
    [cell setDataWith:dic];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    [center addObserver:self selector:@selector(changeView:) name:CHANGE_VIEW object:nil];
    [center addObserver:self selector:@selector(pushViewController:) name:PUSH_VIEW object:nil];
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
