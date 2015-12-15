//
//  ThreeHourInfo.m
//  PocketTools
//
//  Created by yc on 15-3-23.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ThreeHourInfo.h"

@implementation ThreeHourInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.weatherid = attributes[@"weatherid"];
        self.weather = attributes[@"weather"];
        self.temp1 = attributes[@"temp1"];
        self.temp2 = attributes[@"temp2"];
        self.sh = attributes[@"sh"];
        self.eh = attributes[@"eh"];
        self.date = attributes[@"date"];
        self.sfdate = attributes[@"sfdate"];
        self.efdate = attributes[@"efdate"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *hoursInfo = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        ThreeHourInfo *hourInfo = [[ThreeHourInfo alloc] initWithAttributes:array[i]];
        [hoursInfo addObject:hourInfo];
    }
    return hoursInfo;
}
@end
