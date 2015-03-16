//
//  WeatherTodayInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherTodayInfo.h"

@implementation WeatherTodayInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.city = attributes[@"city"];
        self.date_y = attributes[@"date_y"];
        self.week = attributes[@"week"];
        self.temperature = attributes[@"temperature"];
        self.weather = attributes[@"weather"];
        self.weather_id = attributes[@"weather_id"];
        self.wind = attributes[@"wind"];
        self.dressing_index = attributes[@"dressing_index"];
        self.dressing_advice = attributes[@"dressing_advice"];
        self.uv_index = attributes[@"uv_index"];
        self.comfort_index = attributes[@"comfort_index"];
        self.wash_index = attributes[@"wash_index"];
        self.travel_index = attributes[@"traverl_index"];
        self.exercise_index = attributes[@"exercise_index"];
        self.drying_index = attributes[@"drying_index"];
    }
    return self;
}
@end
