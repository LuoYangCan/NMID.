//
//  CYTableViewCell.h
//  Young Eagles
//
//  Created by NMID on 2017/3/21.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString *const cellID = @"cellID";
@interface CYTableViewCell : UITableViewCell
@property (strong,nonatomic) UIImageView *leftimage;
@property (strong,nonatomic) UILabel *tLabel;
@property (strong,nonatomic) UILabel *imlabel;
@end
