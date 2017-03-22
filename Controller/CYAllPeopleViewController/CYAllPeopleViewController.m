//
//  CYAllPeopleViewController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYAllPeopleViewController.h"
#import "CYTableViewCell.h"
@interface CYAllPeopleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) NSArray *projectName;
@property(nonatomic,strong) NSArray *peopleName;
@end

@implementation CYAllPeopleViewController

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
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
    NSArray *templist = [self.dic allKeys];
    self.projectName = [templist sortedArrayUsingSelector:@selector(compare:)];
    self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.TableView];
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

-(NSString *)getFirstWordFrom:(NSArray *)StrArray andRow:(NSIndexPath *)indexPath{
    NSString *allWord = [StrArray objectAtIndex:indexPath.row];
    NSString *FirstWord = [allWord substringToIndex:1];
    return FirstWord;
}

- (UIColor *)getColorfrom:(NSIndexPath *)IndexPath{
    switch (IndexPath.row) {
        case 0:
            return [UIColor orangeColor];
            break;
        case 1:
            return [UIColor redColor];
            break;
        case 2:
            return [UIColor purpleColor];
            break;
        case 3:
            return [UIColor blueColor];
            break;
        case 4:
            return [UIColor grayColor];
            break;
        case 5:
            return [UIColor greenColor];
            break;
            
        default:
            return [UIColor orangeColor];
            break;
    }
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
    NSString *firstWord = [self getFirstWordFrom:self.peopleName andRow:indexPath];
    UIColor *color = [self getColorfrom:indexPath];
    cell.leftimage.backgroundColor = color;
    cell.imlabel.text = firstWord;
    //UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CYProjectViewCellIndentifier"];
    // cell.textLabel.text = self.projectName[indexPath.row];
    
    
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
