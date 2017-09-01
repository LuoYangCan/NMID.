//
//  CYNetwork.m
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYNetwork.h"

@implementation CYNetwork
static AFHTTPSessionManager *mgr = nil;

+(AFHTTPSessionManager *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:baseURL]];
    });
    return mgr;
}




@end
