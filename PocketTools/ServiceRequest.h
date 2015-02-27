//
//  ServiceRequest.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

//#define APP_ID @"e2a4d76a04bc042a8b47045baf6c9873"
#define SUCCESS_CODE 200
#define DEVICE_ID @"device_id"

@interface ServiceRequest : NSObject

- (void)saveAppID:(NSString *)appId;

- (NSString *)getAppId;

+ (instancetype)shared;

//获取苹果序列号信息
- (void)appleInfo:(NSString *)appid
        withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//身份证查询
- (void)idCardSearch:(NSString *)uid
           withBlocl:(void (^)(NSDictionary *result, NSError *error))block;
@end
