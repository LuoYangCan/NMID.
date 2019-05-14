//
//  textViewController.m
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2019/4/30.
//  Copyright © 2019 NMID. All rights reserved.
//

#import "textViewController.h"
#import "CYHelper.h"
#import "CYProgressHUD.h"
#import "CYDocument.h"

@interface textViewController ()
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UITextView *textView;        /**< 文字  */
@property (nonatomic, strong) UIButton *uploadButton;        /**< 提交按钮  */
@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.tabBarController.tabBar.hidden = YES;
    
    self.titleText = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, screenWidth - 40, 40)];
    self.titleText.borderStyle = UITextBorderStyleRoundedRect;
    self.titleText.placeholder = @"输入标题";
//    self.titleText.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.titleText];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 80, screenWidth - 40, screenHeight - 260)];
//    self.textView.backgroundColor = [UIColor orangeColor];
    self.textView.layer.borderColor = [UIColor colorWithRed:215.0/255.0 green:215.0/255.0 blue:215.0/255.0 alpha:1].CGColor;
    self.textView.layer.cornerRadius = 6.0f;
    self.textView.layer.borderWidth = 0.6f;
    [self.textView.layer masksToBounds];
    [self.view addSubview:self.textView];
    
    
    self.uploadButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 507, screenWidth - 40, 40)];
    [self.uploadButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.uploadButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.uploadButton addTarget:self action:@selector(submitTextAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.uploadButton];
}


- (void)submitTextAction {
    if (self.titleText.text.length <= 0) {
        [[CYProgressHUD sharedHUD]showText:@"请输入标题" inView:self.view HideAfterDelay:1.5];
        return;
    }
    if (self.textView.text.length <= 0) {
        [[CYProgressHUD sharedHUD]showText:@"请输入内容" inView:self.view HideAfterDelay:1.5];
        return;
    }
    //创建URL
    NSString *titleURL = self.titleText.text;
    NSString *fileName = [NSString stringWithFormat:@"%@.text",titleURL];
    NSURL *url = [self getUbiquityFileURL:fileName];
    
    CYDocument *document = [[CYDocument alloc] initWithFileURL:url];
    document.data = [self.textView.text dataUsingEncoding:NSUTF8StringEncoding];
    [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
        if (success) {
            [[CYProgressHUD sharedHUD]showText:@"创建成功" inView:self.view HideAfterDelay:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[CYProgressHUD sharedHUD]showText:@"创建失败" inView:self.view HideAfterDelay:1.5];
        }
    }];
    
}

- (NSURL *)getUbiquityFileURL:(NSString *)fileName {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [manager URLForUbiquityContainerIdentifier:kContainerIdentifier];
    url = [url URLByAppendingPathComponent:@"Documents"];
    url = [url URLByAppendingPathComponent:fileName];
    return url;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.titleText resignFirstResponder];
}
@end
