//
//  ScanCityInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ScanCityInfo.h"

@implementation ScanCityInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.cid = attributes[@"_id"];
        self.cityName = attributes[@"cityName"];
        self.lat = attributes[@"lat"];
        self.lng = attributes[@"lng"];
        self.provinceId = attributes[@"provinceId"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *cArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        ScanCityInfo *info = [[ScanCityInfo alloc] initWithAttributes:array[i]];
        [cArray addObject:info];
    }
    return cArray;
}
@end
