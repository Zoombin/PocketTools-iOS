//
//  ServiceRequest.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ServiceRequest.h"

@implementation ServiceRequest

#define BASE_URL  @"http://apis.juhe.cn"

static AFHTTPRequestOperationManager *manager;
static ServiceRequest *request;

+ (instancetype)shared {
    if (!request) {
        request = [[ServiceRequest alloc] init];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return request;
}

- (void)saveAppID:(NSString *)appId {
    if ([appId isEqualToString:@""]) {
        return;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:appId forKey:DEVICE_ID];
    [userDefault synchronize];
}

- (NSString *)getAppId {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:DEVICE_ID];
}

- (NSMutableDictionary *)getRequestParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"dtype"] = @"json";
    return params;
}

//获取苹果序列号信息
- (void)appleInfo:(NSString *)appid withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"sn"] = appid;
    params[@"key"] = @"e2a4d76a04bc042a8b47045baf6c9873";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/appleinfo/index", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)idCardSearch:(NSString *)uid
           withBlocl:(void (^)(NSDictionary *result, NSError *error))block
{
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"cardno"] = uid;
    params[@"key"] = @"51431019e527a0cd73e5daf157348e84";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/idcard/index", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//IP查询
- (void)ipSearch:(NSString *)ip
       withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"ip"] = ip;
    params[@"key"] = @"07710610d64e235e50b257308b2aea76";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/ip/ip2addr", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//电话查询
- (void)phoneSearch:(NSString *)phoneNum
          withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"phone"] = phoneNum;
    params[@"key"] = @"b8b61acf82e1866e41a67c53e295f51b";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/mobile/get", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//聊天机器人
- (void)chatWithRobot:(NSString *)content
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"info"] = content;
    params[@"key"] = @"39ded27a75232bba451702ab705faeea";
    NSString *requestUrl = @"http://op.juhe.cn/robot/index";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//汇率计算
- (void)exchangeList:(void (^)(NSDictionary *, NSError *))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"ecfbba891b63a81c297ec1afb690d5ad";
    NSString *requestUrl = @"http://web.juhe.cn:8080/finance/exchange/rmbquot";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%ld", (long)operation.response.statusCode);
        if (operation.response.statusCode == 200) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
            block(jsonDict, nil);
            return;
        }
        block(nil, error);
    }];
}

@end
