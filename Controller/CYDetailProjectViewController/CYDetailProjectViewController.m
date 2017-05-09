//
//  CYDetailProjectViewController.m
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYDetailProjectViewController.h"
#import "CYTableViewCell.h"
#import "CYHelper.h"
@interface CYDetailProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *DetailTableView; /**<  显示详细Tableview*/
@property (nonatomic,strong) NSArray *ProjectMember; /**< 项目组成员数组*/
@end

@implementation CYDetailProjectViewController

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
    self.view.backgroundColor =[UIColor whiteColor];
    self.DetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width, self.view.bounds.size.height-65)];
    self.DetailTableView.delegate = self;
    self.DetailTableView.dataSource = self;
    self.DetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.DetailTableView];

}

- (instancetype) initWithProjectInfo:(NSDictionary *)ProjectMemberArray{
    if (self = [super init]) {
        self.ProjectMember = (NSArray *)ProjectMemberArray;
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate&&UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ProjectMember.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTableViewCell * cell = [[CYTableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tLabel.text = self.ProjectMember[indexPath.row];
    cell.leftimage.backgroundColor = [CYHelper getColorfrom:indexPath];
    cell.imlabel.text = [CYHelper getFirstWordFrom:self.ProjectMember andRow:indexPath];
    return cell;
}
@end
