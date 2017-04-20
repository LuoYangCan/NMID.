//
//  CYManagerView.m
//  Young Eagles
//
//  Created by NMID on 2017/4/10.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYManagerView.h"
#import "CYHelper.h"
@interface CYManagerView()
@property(nonatomic,strong) UIScrollView *topScro;


@end

@implementation CYManagerView
-(instancetype)init{
    if (self = [super init]) {
        [self initTop];
    }
    return self;
}

-(void)initTop{
    self.topScro = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    self.topScro.backgroundColor = RBlue;
    [self addSubview:self.topScro];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(screenWidth /2 -35.5, 25, 80, 25)];
    title.text = @"管理手册";
    title.font = [UIFont systemFontOfSize:19];
    [self.topScro addSubview:title];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
