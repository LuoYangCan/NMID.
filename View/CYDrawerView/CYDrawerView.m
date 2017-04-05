//
//  CYDrawerView.m
//  Young Eagles
//
//  Created by NMID on 2017/3/27.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYDrawerView.h"
#import "CYHelper.h"
@interface CYDrawerView ()



@end
@implementation CYDrawerView

- (instancetype)init{
    if (self = [super init]) {
        UIButton *projName = [[UIButton alloc]initWithFrame:CGRectMake(60, screenHeight / 3 , 120, 40)];
      //  projName = [UIButton buttonWithType:UIButtonTypeCustom];
        [projName setTitle:@"项目人员" forState:UIControlStateNormal];
        projName.titleLabel.font = [UIFont systemFontOfSize:17];
        [projName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        projName.backgroundColor = [UIColor orangeColor];
        [self addSubview:projName];
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

@end
