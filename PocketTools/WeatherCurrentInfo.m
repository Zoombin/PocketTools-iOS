//
//  WeatherCurrentInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherCurrentInfo.h"

@implementation WeatherCurrentInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.temp = attributes[@"temp"];
        self.wind_direction = attributes[@"wind_direction"];
        self.wind_strength = attributes[@"wind_strength"];
        self.humidity = attributes[@"humidity"];
        self.time = attributes[@"time"];
    }
    return self;
}
@end
