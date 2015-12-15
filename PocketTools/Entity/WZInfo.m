//
//  WZInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WZInfo.h"
#import "WZDetailInfo.h"

@implementation WZInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.province = attributes[@"province"];
        self.cityCode = attributes[@"city"];
        self.carNum = attributes[@"hphm"];
        self.carType = attributes[@"hpzl"];
        self.lists = [WZDetailInfo initWithArray:attributes[@"lists"]];
    }
    return self;
}

@end
