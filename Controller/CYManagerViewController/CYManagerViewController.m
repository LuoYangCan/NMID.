//
//  CYManagerViewController.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/5/23.
//  Copyright © 2017年 NMID. All rights reserved.
//

#define kSCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
#define kSCREENWIDTH   [UIScreen mainScreen].bounds.size.width

#import "CYManagerViewController.h"
#import "iCloudHelper.h"
#import "CYDocument.h"
#import "textViewController.h"


@interface CYManagerViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak)NSUbiquitousKeyValueStore *keyValue;
@property (nonatomic, strong) CYDocument *document;        /**< 文档  */
@property (nonatomic, strong) NSMetadataQuery *query;        /**< 查询列表  */
@property (nonatomic, strong) NSMutableDictionary *files;        /**< 数据  */
@property (nonatomic, strong) UITableView *tableView;        /**< 列表  */
@property (nonatomic, strong) UILabel *dataLabel;        /**< 无数据时的label  */
@end

@implementation CYManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupiCloud];
}

- (void)setupUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSCREENWIDTH, kSCREENHEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kSCREENHEIGHT / 2, kSCREENWIDTH, 20)];
    self.dataLabel.textAlignment = NSTextAlignmentCenter;
    self.dataLabel.text = @"您现在没有文档数据哦";
    [self.view addSubview:self.dataLabel];
    self.dataLabel.hidden = true;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewDoc)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)createNewDoc {
    textViewController *textVC = [[textViewController alloc] init];
    [self.navigationController pushViewController:textVC animated:YES];
}

- (void)setupiCloud {
    if (!self.query) {
        self.query = [[NSMetadataQuery alloc] init];
        self.query.searchScopes = @[NSMetadataQueryUbiquitousDocumentsScope];
        NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
        
        [notiCenter addObserver:self
                       selector:@selector(handleQueryStatus:)
                           name:NSMetadataQueryDidFinishGatheringNotification
                         object:self.query];
        
        [notiCenter addObserver:self
                       selector:@selector(handleQueryStatus:)
                           name:NSMetadataQueryDidUpdateNotification
                         object:self.query];
    }
    [self.query startQuery];
}


- (void)handleQueryStatus:(NSNotification *)noti {
    NSArray *items = self.query.results;
    self.files = [NSMutableDictionary dictionary];
    //变量结果集，存储文件名称、创建日期
    [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMetadataItem *item = obj;
        //获取文件名
        NSString *fileName = [item valueForAttribute:NSMetadataItemFSNameKey];
        //获取文件创建日期
        NSDate *date = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        NSDateFormatter *dateformate = [[NSDateFormatter alloc]init];
        dateformate.dateFormat = @"YY-MM-dd HH:mm";
        NSString *dateString = [dateformate stringFromDate:date];
        //保存文件名和文件创建日期
        [self.files setObject:dateString forKey:fileName];
    }];
    if (self.files.count == 0) {
        self.dataLabel.hidden = false;
    }
    [self.tableView reloadData];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tableViewDefaultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewDefaultCell"];
    }
    NSArray *fileNames = self.files.allKeys;
    NSString *fileName = fileNames[indexPath.row];
    cell.textLabel.text = fileName;
    cell.detailTextLabel.text = [self.files objectForKey:fileName];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}
@end
