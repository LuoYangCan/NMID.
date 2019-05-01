//
//  iCloudHelper.h
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2019/4/26.
//  Copyright © 2019 NMID. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface iCloudHelper : NSObject
@property (nonatomic, strong) NSUbiquitousKeyValueStore *keyValueStore;        /**< iCloud 键值对  */

+ (instancetype)sharedManager;
- (void)saveDataToiCloudWithObject:(id)object forKey:(NSString *)key;
- (void)loadObjectForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
