
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
#import "CYNetwork.h"
#import "CYProgressHUD.h"

@interface CYAllPeopleView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
//@property(nonatomic,strong) NSDictionary *dic;
//@property(nonatomic,strong) NSArray *projectName;
@property (nonatomic,strong) NSArray *infoArray;        /**< 信息数组  */
@property(nonatomic,strong) NSMutableArray *peopleName;

@end

@implementation CYAllPeopleView

-(NSMutableArray *)peopleName{
    if (!_peopleName) {
        _peopleName = [[NSMutableArray alloc]init];
    }
    return _peopleName;
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = wholeScreen;
        [self setup];
    }
    return self;
}
-(void)setup{
//    NSBundle *bundle = [NSBundle mainBundle];
//    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
//    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
//    NSArray *templist = [self.dic allKeys];
//    self.projectName = [templist sortedArrayUsingSelector:@selector(compare:)];
    [self initTableView];
    [self getAllPeopleName];
    
}
-(void)initTableView{
        self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.TableView.delegate = self;
        self.TableView.dataSource = self;
        self.TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:self.TableView];
}
-(void)getAllPeopleName{
//    self.peopleName = [[NSArray alloc]init];
//    NSMutableArray *peopl = [NSMutableArray array];
//    for (NSInteger IN=0; IN <= 6; IN++) {
//        NSString *groupname = [self.projectName objectAtIndex:IN];
//        NSArray *tempArr = [self.dic objectForKey:groupname];
//        [peopl addObjectsFromArray:tempArr];
//    }
//    self.peopleName = [peopl valueForKeyPath:@"@distinctUnionOfObjects.self"] ;
    @weakify(self);
    [[CYNetwork sharedManager]get_ReuqestwithURLParameters:@"/getUserList" completion:^(NSError * error, id resonse, NSURLSessionTask * task) {
        @strongify(self);
        if (error) {
            [[CYProgressHUD sharedHUD]showText:error.description inView:self HideAfterDelay:1.0f];
        }else if(!error){
            self.infoArray = [NSArray arrayWithArray:resonse];
            if (self.peopleName) {
                [self.peopleName removeAllObjects];
            }
            for (NSDictionary * dic in self.infoArray) {
                NSString *name = dic[@"userName"];
                [self.peopleName addObject:name];
            }
        }

    }];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tLabel.text = self.peopleName[indexPath.row];
    NSString *firstWord = [CYHelper getFirstWordFrom:self.peopleName andRow:indexPath];
    UIColor *color = [CYHelper getColorfrom:indexPath];
    cell.leftimage.backgroundColor = color;
    cell.imlabel.text = firstWord;
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CYProjectViewCellIndentifier"];
    // cell.textLabel.text = self.projectName[indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *infoDic = self.infoArray[indexPath.row];
    [[NSNotificationCenter defaultCenter]postNotificationName:PUSH_VIEW object:nil userInfo:infoDic];
}

@end
