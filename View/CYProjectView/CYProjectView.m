//
//  CYProjectView.m
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYTableViewCell.h"
#import "CYDetailProjectViewController.h"
#import "CYProjectView.h"
@interface CYProjectView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) NSArray *projectName;
@end

@implementation CYProjectView
-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 70, screenWidth, screenHeight);
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
    self.projectName = [self.dic allKeys];
    self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-65)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.TableView];
    
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
    
    return self.projectName.count ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTableViewCell *cell = [[CYTableViewCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tLabel.text = self.projectName[indexPath.row];
    NSString *firstWord = [CYHelper getFirstWordFrom:self.projectName andRow:indexPath];
    UIColor *color = [CYHelper getColorfrom:indexPath];
    cell.leftimage.backgroundColor = color;
    cell.imlabel.text = firstWord;
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CYProjectViewCellIndentifier"];
    // cell.textLabel.text = self.projectName[indexPath.row];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * projectName = self.projectName[indexPath.row];
    NSArray *projectMember = self.dic[projectName];
    NSDictionary *NotiDic = @{@"1":projectMember,
                              @"2":projectName};
    NSNotification *notice = [NSNotification notificationWithName:@"pushView" object:nil userInfo:NotiDic];
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
   }

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
