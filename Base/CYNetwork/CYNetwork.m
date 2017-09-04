//
//  CYNetwork.m
//  雏鹰计划
//
//  Created by 孤岛 on 2017/9/1.
//  Copyright © 2017年 NMID. All rights reserved.
//

#import "CYNetwork.h"
#import <AFNetworking.h>
#import "CYHelper.h"

static NSString * const  baseURL = @"http://47.93.231.115:8080/api/eyas";
@implementation CYNetwork
static CYNetwork * _sharedNetwork = nil;

+(CYNetwork *)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetwork = [[CYNetwork alloc]init];
    });
    return _sharedNetwork;
    
}

-(void)post_RequestwithData:(NSString *)data Completion:(void (^)(NSError *, id , NSURLSessionTask * ))Completionblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@",baseURL,data] parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (Completionblock) {
            Completionblock(nil, responseObject, task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Completionblock) {
            Completionblock(error, nil, task);
        }
    }];
    
    
}

-(void)RequestwithData:(NSDictionary *)data andURLParameters:(NSString *)parameters Completion:(void (^)(NSError *, id , NSURLSessionTask * ))Completionblock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *Requestdata = [NSJSONSerialization dataWithJSONObject:data options:0 error:nil];
    NSString *RequestStr = [[NSString alloc]initWithData:Requestdata encoding:NSUTF8StringEncoding];
    [manager POST:[NSString stringWithFormat:@"%@%@",baseURL,parameters] parameters:RequestStr progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (Completionblock) {
            Completionblock(nil,responseObject,task);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (Completionblock) {
            Completionblock(error, nil, task);
        }
    }];
    
    
}


@end
