//
//  CityInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CityInfo.h"

@implementation CityInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.abbr = attributes[@"abbr"];
        self.cityCode = attributes[@"city_code"];
        self.cityName = attributes[@"city_name"];
        self.class = attributes[@"class"];
        self.classa = attributes[@"classa"];
        self.classno = attributes[@"classno"];
        self.engine = attributes[@"engine"];
        self.engineno = attributes[@"engineno"];
        self.regist = attributes[@"regist"];
        self.registno = attributes[@"registno"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)arr {
    if (arr == nil) {
        return nil;
    }
    NSMutableArray *cities = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        CityInfo *info = [[CityInfo alloc] initWithAttributes:arr[i]];
        [cities addObject:info];
    }
    return cities;
}
@end
