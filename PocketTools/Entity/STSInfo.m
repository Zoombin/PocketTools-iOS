//
//  STSInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "STSInfo.h"

@implementation STSInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.trainOpp = attributes[@"trainOpp"];
        self.train_typename = attributes[@"train_typename"];
        self.start_staion = attributes[@"start_staion"];
        self.end_station = attributes[@"end_station"];
        self.leave_time = attributes[@"leave_time"];
        self.arrived_time = attributes[@"arrived_time"];
        self.mileage = attributes[@"mileage"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *stsInfos = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        STSInfo *info = [[STSInfo alloc] initWithAttributes:array[i]];
        [stsInfos addObject:info];
    }
    return stsInfos;
}
@end
