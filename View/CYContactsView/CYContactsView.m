//
//  CYContactsView.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/4/26.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYProjectView.h"
#import "CYAllPeopleView.h"
#import "CYContactsView.h"
@interface CYContactsView()
@property(nonatomic,strong) CYProjectView *PV;
@property(nonatomic,strong) CYAllPeopleView *ALLV;
@property(nonatomic,strong) UIButton *LeftBtn;
@property(nonatomic,strong) UISegmentedControl *segment;
@end
@implementation CYContactsView

- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setup{
    [self initUI];
    [self initsegment];
}
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    self.LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 29, 30, 30)];
    [self.LeftBtn setImage:[UIImage imageNamed:@"Menu-40"] forState:UIControlStateNormal];
    [self.LeftBtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    self.PV = [[CYProjectView alloc]init];
    self.ALLV = [[CYAllPeopleView alloc]init];
    [self addSubview:self.PV];
    [self addSubview:self.LeftBtn];
}

-(void)showLeftView{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"showLeft" object:nil];
}
-(CGRect)framewithoffsetX:(CGFloat)offsetX{
    CGRect frame = self.frame;
    frame.origin.x += offsetX;
    if (frame.origin.x >= LeftOffX) {
        frame.origin.x = LeftOffX;
    }else if (frame.origin.x <= 0){
        frame.origin.x = 0;
    }
    return frame;
}
#pragma mark - 初始化segmentControl
- (void)initsegment{
self.segment = [[UISegmentedControl alloc]initWithItems:@[@"项目组",@"所有人"]];   //设置名字
self.segment.frame = CGRectMake(screenWidth/2-100, 27,200, 33);
    self.segment.selectedSegmentIndex = 0;                              //设置初始位置
    [self.segment addTarget:self action:@selector(segmentdidChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.segment];
}
#pragma mark -segment改变
- (void)segmentdidChange:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            [self.ALLV removeFromSuperview];
            break;
        case 1:
            [self addSubview:self.ALLV];
        default:
            break;
    }
}

@end
