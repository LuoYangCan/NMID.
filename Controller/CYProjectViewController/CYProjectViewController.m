//
//  CYProjectViewController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYProjectViewController.h"

@interface CYProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) NSArray *projectName;
@end

@implementation CYProjectViewController

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
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.rowHeight = 70;
    self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.TableView];
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
    NSArray *templist = [self.dic allKeys];
    self.projectName = [templist sortedArrayUsingSelector:@selector(compare:)];
    
}
/*
-(void)DictionarySetup{
    self.dic = [[NSDictionary alloc]init];
    self.dic = @{@"运营专责":@"张挺"@"陈思捷"@"杨键"@"张文梁",
                 @"中学指导":@"瞿强"@"李艺"@"李才猛"@"马宪羽",
                 @"智能运动终端":@"匡正泽"@"周家豪"@"张兴锐"@"黄嘉豪"@"李云飞"@"施伟成",
                 @"基于移动互联的硬件交互反馈系统":@"雷志涵"@"陈恳"@"张怀艺"@"余承熹"@"税樱姿"@"邓成超",
                 @"自行车行车安全导航仪":@"胡炳昭"@"袁瑞"@"匡正泽"@"李思佚"@"余冰",
                 @"城市公厕资源调配系统":@"陈思捷"@"高小明"@"周鑫"@"万雨豪"@"周海林",
                 @"基于web的文件管理系统":@"罗浩"@"王义青"@"何金林"@"喻启洋"
                 };
}*/

#pragma mark -UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CYProjectViewCellIndentifier"];
    return cell;
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
