//
//  CYTableViewCell.m
//  Young Eagles
//
//  Created by NMID on 2017/3/21.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation CYTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 80);
        _leftimage= [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 50, 50)];
        UIBezierPath *maskpath =[UIBezierPath bezierPathWithRoundedRect:_leftimage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_leftimage.bounds.size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = _leftimage.bounds;
        maskLayer.path = maskpath.CGPath;
        _leftimage.layer.mask = maskLayer;
        _tLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, 30, ScreenWidth, 16)];
        _tLabel.textAlignment = NSTextAlignmentLeft;
        _imlabel = [[UILabel alloc]initWithFrame:CGRectMake(11.5, -2, 45, 55)];
        _imlabel.font = [UIFont systemFontOfSize:27];
        _imlabel.textColor = [UIColor whiteColor];
        [self.leftimage addSubview:_imlabel];
        [self addSubview:_leftimage];
        [self addSubview:_tLabel];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)reuseIdentifier{
    return cellID;
}

@end

