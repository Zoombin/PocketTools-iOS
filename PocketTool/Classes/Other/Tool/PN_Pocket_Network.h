//
//  PN_Pocket_Network.h
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PN_Pocket_Network : NSObject
//手机号码归属地请求
+ (void)getinfoWithPhoneNum:(NSString *)phoneNum success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
