
//
//  CYHomeView.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/4/27.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHomeTableCell.h"
#import "CYHelper.h"
#import "CYHomeView.h"
@interface CYHomeView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *HomeTable;
@end

@implementation CYHomeView

-(instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    [self initUI];
    
}

-(void)initUI{
    self.frame = NormalSize;
    self.backgroundColor = [UIColor whiteColor];
    _HomeTable = [[UITableView alloc]initWithFrame:wholeScreen style:UITableViewStylePlain];
    _HomeTable.delegate = self;
    _HomeTable.dataSource = self;
    [self addSubview:_HomeTable];
}

#pragma mark - UITableViewDelegate&&UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYHomeTableCell *cell = [[CYHomeTableCell alloc]init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = @{@"name":@"Reus",
                          @"title":@"关于基于iCloud的文件管理系统App",
                          @"time" : @"2017-09-20",
                          @"headIcon":@"Contacts-50",
                          @"dcContent":@"这是一个四行显示的内容，应该有很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长很长的文字"
                          };
    [cell setDataWith:dic];
    
    return cell;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
