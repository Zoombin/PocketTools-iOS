//
//  ProvinceInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ProvinceInfo.h"
#import "CityInfo.h"

@implementation ProvinceInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.citys = [CityInfo initWithArray:attributes[@"citys"]];
        self.province = attributes[@"province"];
        self.provinceCode = attributes[@"province_code"];
    }
    return self;
}
@end
