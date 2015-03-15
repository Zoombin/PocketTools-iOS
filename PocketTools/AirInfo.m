//
//  AirInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "AirInfo.h"

@implementation AirInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.city = attributes[@"city"];
        self.PM25 = attributes[@"PM2.5"];
        self.AQI = attributes[@"quality"];
        self.PM10 = attributes[@"PM10"];
        self.CO = attributes[@"CO"];
        self.NO2 = attributes[@"NO2"];
        self.O3 = attributes[@"O3"];
        self.SO2 = attributes[@"SO2"];
        self.time = attributes[@"time"];
    }
    return self;
}
@end
