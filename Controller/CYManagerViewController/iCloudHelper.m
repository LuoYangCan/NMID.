//
//  iCloudHelper.m
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2019/4/26.
//  Copyright © 2019 NMID. All rights reserved.
//

#import "iCloudHelper.h"

@implementation iCloudHelper

+ (instancetype)sharedManager {
    static iCloudHelper *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[iCloudHelper alloc] init];
    });
    return sharedManager;
}

- (void)saveDataToiCloudWithObject:(id)object forKey:(NSString *)key {
    [self.keyValueStore setObject:object forKey:key];
    [self.keyValueStore synchronize];
}

- (void)loadObjectForKey:(NSString *)key {
    [self.keyValueStore objectForKey:key];
}


#pragma mark - LazyLoad
- (NSUbiquitousKeyValueStore *)keyValueStore {
    if (!_keyValueStore) {
        _keyValueStore = [NSUbiquitousKeyValueStore defaultStore];
    }
    return _keyValueStore;
}

@end
