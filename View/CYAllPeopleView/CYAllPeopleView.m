
//
//  CYAllPeopleView.m
//  Young Eagles
//
//  Created by NMID on 2017/4/1.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYAllPeopleView.h"
#import "CYHelper.h"
#import "CYTableViewCell.h"
@interface CYAllPeopleView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) NSArray *projectName;
@property(nonatomic,strong) NSArray *peopleName;

@end

@implementation CYAllPeopleView
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 65, screenWidth, screenHeight-65);
        [self setup];
    }
    return self;
}
-(void)setup{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
    NSArray *templist = [self.dic allKeys];
    self.projectName = [templist sortedArrayUsingSelector:@selector(compare:)];
    self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-65)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.TableView];
    [self getAllPeopleName];
    
}
-(void)getAllPeopleName{
    self.peopleName = [[NSArray alloc]init];
    NSMutableArray *peopl = [NSMutableArray array];
    for (NSInteger IN=0; IN <= 6; IN++) {
        NSString *groupname = [self.projectName objectAtIndex:IN];
        NSArray *tempArr = [self.dic objectForKey:groupname];
        [peopl addObjectsFromArray:tempArr];
    }
    self.peopleName = [peopl valueForKeyPath:@"@distinctUnionOfObjects.self"] ;
}


#pragma mark -UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.peopleName.count ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYTableViewCell *cell = [[CYTableViewCell alloc]init];
    cell.selectionStyle = UITableViewRowAnimationNone;
    cell.tLabel.text = self.peopleName[indexPath.row];
    NSString *firstWord = [CYHelper getFirstWordFrom:self.peopleName andRow:indexPath];
    UIColor *color = [CYHelper getColorfrom:indexPath];
    cell.leftimage.backgroundColor = color;
    cell.imlabel.text = firstWord;
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CYProjectViewCellIndentifier"];
    // cell.textLabel.text = self.projectName[indexPath.row];
    
    
    return cell;
}



@end
