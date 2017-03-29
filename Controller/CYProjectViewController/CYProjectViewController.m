//
//  CYProjectViewController.m
//  Young Eagles
//
//  Created by NMID on 2017/3/18.
//  Copyright © 2017年 NMID. All rights reserved.
//
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#import "CYProjectViewController.h"
#import "CYTableViewCell.h"
#import "CYDrawerView.h"
@interface CYProjectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *TableView; /**<   列表*/
@property(nonatomic,strong) NSDictionary *dic;
@property(nonatomic,strong) NSArray *projectName;
@property(nonatomic,assign) CGFloat maxY;
@property(nonatomic,assign) CGFloat offsetLeft;
@property(nonatomic,strong) UIView *mainView;
@end

@implementation CYProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxY = 0;
    self.offsetLeft = -(screenWidth * 0.7);
    [self setupUI];
    [self setupGesture];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    self.mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistpath = [bundle pathForResource:@"Property List" ofType:@"plist"];
    self.dic = [[NSDictionary alloc]initWithContentsOfFile:plistpath];
    NSArray *templist = [self.dic allKeys];
    self.projectName = [templist sortedArrayUsingSelector:@selector(compare:)];
    self.TableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mainView.bounds.size.width, self.mainView.bounds.size.height)];
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.TableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.mainView addSubview:self.TableView];
    [self.view addSubview:self.mainView];
    UIView *leftView = [[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:leftView];
    
}

- (void) setupGesture{
    UIPanGestureRecognizer *PAN = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(selector)];
    [self.mainView addGestureRecognizer:PAN];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tapGes)];
    
    [self.view addGestureRecognizer:tap];
}
- (void)tapGes{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainView.frame = self.view.bounds;
    }];
}
-(void)pan:(UIPanGestureRecognizer *)pan{
    CGPoint finger = [pan translationInView:self.mainView];
    self.mainView.frame = [self framewithoffsetX:finger.x];
    CGFloat target = 0 ;
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (self.mainView.frame.origin.x < screenWidth * 0.5) {
            target = self.offsetLeft ;
        }
        CGFloat offsetX = target - self.mainView.frame.origin.x;
        [UIView animateWithDuration:0.25 animations:^{
            self.mainView.frame = [self framewithoffsetX:offsetX];
        }];
    }
    [pan setTranslation:CGPointZero inView:self.mainView];
    
}

-(CGRect)framewithoffsetX:(CGFloat)offsetX{
    CGRect frame = self.mainView.frame;
    frame.origin.x += offsetX;
    return frame;
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
    NSString *firstWord = [self getFirstWordFrom:self.projectName andRow:indexPath];
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
