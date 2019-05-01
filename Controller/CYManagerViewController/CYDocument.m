//
//  CYDocument.m
//  基于iCloud的文件管理系统
//
//  Created by 孤岛 on 2019/4/27.
//  Copyright © 2019 NMID. All rights reserved.
//

#import "CYDocument.h"

@implementation CYDocument

- (id)contentsForType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    if (!self.data) {
        self.data = [NSData data];
    }
    return self.data;
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = [contents copy];
    return true;
}
@end
