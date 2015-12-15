//
//  WeatherFutureInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherFutureInfo.h"

@implementation WeatherFutureInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.temperature = attributes[@"temperature"];
        self.weather = attributes[@"weather"];
        self.weather_id = attributes[@"weather_id"];
        self.wind = attributes[@"wind"];
        self.week = attributes[@"week"];
        self.date = attributes[@"date"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *futureInfos = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        WeatherFutureInfo *info = [[WeatherFutureInfo alloc] initWithAttributes:array[i]];
        [futureInfos addObject:info];
    }
    return futureInfos;
}
@end
