
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
    self.backgroundColor = [UIColor grayColor];
    _HomeTable = [[UITableView alloc]initWithFrame:wholeScreen style:UITableViewStylePlain];
    _HomeTable.delegate = self;
    _HomeTable.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYHomeTableCell *cell = [[CYHomeTableCell alloc]init];
    
    
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
