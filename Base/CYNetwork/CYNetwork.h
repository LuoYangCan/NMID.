//
//  CYNetwork.h
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
static NSString * const  baseURL = @"47.93.231.115:8080/api/eyas";
@interface CYNetwork : NSObject


/**
 初始化

 @return Mgr
 */
+ (AFHTTPSessionManager *)sharedManager;









@end
