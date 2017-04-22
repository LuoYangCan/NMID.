//
//  CYExpertsView.m
//  Young Eagles
//
//  Created by NMID on 2017/4/10.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYExpertsView.h"
#import "CYHelper.h"
@interface CYExpertsView()
@property (nonatomic,strong) UIButton *LeftBtn;
@end
@implementation CYExpertsView
-(instancetype)init{
    if (self = [super init]) {
    self.backgroundColor = ROrange;
    [self setup];
    }
    return self;
}
-(void)setup{
    self.LeftBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 29, 30, 30)];
    [self.LeftBtn setImage:[UIImage imageNamed:@"Menu-40"] forState:UIControlStateNormal];
    [self.LeftBtn addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.LeftBtn];
}

-(void)showLeftView{
    if (self.frame.origin.x == screenWidth *0.81) {
        [UIView animateWithDuration:0.25 animations:^{
           super.frame = self.bounds;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            super.frame = [self framewithoffsetX:LeftOffX];
        }];
    }
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
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
