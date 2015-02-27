//
//  ServiceResult.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ServiceResult.h"

@implementation ServiceResult

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.error_code = attributes[@"error_code"];
        self.resultcode = attributes[@"resultcode"];
        self.result = attributes[@"result"];
        self.reason = attributes[@"reason"];
    }
    return self;
}
@end
