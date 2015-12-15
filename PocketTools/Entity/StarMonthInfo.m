//
//  StarMonthInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarMonthInfo.h"

@implementation StarMonthInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.all = attributes[@"all"];
        self.date = attributes[@"date"];
        self.error_code = attributes[@"error_code"];
        self.happyMagic = attributes[@"happyMagic"];
        self.health = attributes[@"health"];
        self.love = attributes[@"love"];
        self.money = attributes[@"money"];
        self.resultcode = attributes[@"resultcode"];
        self.work = attributes[@"work"];
    }
    return self;
}
@end
