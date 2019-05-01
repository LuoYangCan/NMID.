//
//  CYDocument.h
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2019/4/27.
//  Copyright © 2019 NMID. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYDocument : UIDocument
@property (nonatomic, strong) NSData *data;        /**< 文档数据  */
@end

NS_ASSUME_NONNULL_END
