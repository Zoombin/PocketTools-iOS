//
//  PhoneInfo.m
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PhoneInfo.h"

@implementation PhoneInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.province = attributes[@"province"];
        self.city = attributes[@"city"];
        self.areacode = attributes[@"areacode"];
        self.zip = attributes[@"zip"];
        self.company = attributes[@"company"];
        self.card = attributes[@"card"];
    }
    return self;
}
@end
