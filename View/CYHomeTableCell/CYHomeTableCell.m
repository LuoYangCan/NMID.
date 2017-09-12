//
//  CYHomeTableCell.m
//  Young Eagles
//
//  Created by 孤岛 on 2017/4/29.
//  Copyright © 2017年 NMID. All rights reserved.
//
#import "CYHelper.h"
#import "CYHomeTableCell.h"
#define CellWidth self.bounds.size.width
#define CellHeight self.bounds.size.height
@interface CYHomeTableCell()
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * contentLabel;
@property(nonatomic,strong)UIImageView * Icon;
@property(nonatomic,strong)UILabel * UserID;
@property(nonatomic,strong) UILabel *timeLabl;   /**< 时间  */
@end
@implementation CYHomeTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, screenWidth, 140);
        [self setup];
    }
    return self;
}

-(void)setup{
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 170, 20)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor grayColor];
    [self addSubview:_titleLabel];
    
    _Icon = [CYHelper getCycleImageViewwithx:15 y:10 width:20 height:20];
   // _Icon = [[UIImageView alloc]init];
//    _Icon.frame = CGRectMake(15, 10, 20, 20);
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_Icon.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:_Icon.bounds.size];
//    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];
//    masklayer.frame = _Icon.bounds;
//    masklayer.path = maskPath.CGPath;
//    _Icon.layer.mask = masklayer;
    [self addSubview:_Icon];
    
    _timeLabl = [[UILabel alloc]initWithFrame:CGRectMake(260, 40, 120, 20)];
//    [_timeLabl sizeToFit];
    _timeLabl.font = [UIFont systemFontOfSize:16];
    _timeLabl.textColor = [UIColor grayColor];
    [self addSubview:_timeLabl];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 60, CellWidth - 70 , CellHeight - 40)];
    _contentLabel.font = [UIFont systemFontOfSize:16.5f];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.numberOfLines = 4;
    [self addSubview:_contentLabel];
    
    
    _UserID = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, 90, 20)];
    _UserID.font = [UIFont systemFontOfSize:15];
    _UserID.textColor = [UIColor grayColor];
    [self addSubview:_UserID];
    
}
-(void)setDataWith:(NSDictionary *)dataDic{
    _titleLabel.text = dataDic[@"title"];
    NSString *imgname = dataDic[@"headIcon"];
    UIImage *img = [UIImage imageNamed:imgname];
    _Icon.image = img;
    _contentLabel.text = dataDic[@"dcContent"];
    _UserID.text = dataDic[@"name"];
    _timeLabl.text = dataDic[@"time"];
}
@end
