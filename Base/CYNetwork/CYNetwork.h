//
//  CYNetwork.h
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface CYNetwork : NSObject


/**
 初始化

 @return Mgr
 */
+ (CYNetwork *)sharedManager;



/**
 直接添加后缀请求

 @param data 数据
 @param Completionblock 成功block
 */
-(void)post_RequestwithData:(NSString *)data Completion:(void (^)(NSError *, id , NSURLSessionTask * ))Completionblock;
@end
