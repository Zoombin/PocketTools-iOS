//
//  PN_Pocket_Network.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Pocket_Network.h"
#import "PN_httpTool.h"
@implementation PN_Pocket_Network
+ (void)getinfoWithPhoneNum:(NSString *)phoneNum success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSNumber *num = [NSNumber numberWithInteger:[phoneNum integerValue]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:num forKey:@"phone"];
    
    [PN_httpTool getWithURL:@"http://apis.juhe.cn/mobile/get"  params:params success:^(id json) {
        if (success) {
            success(json);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}
@end
