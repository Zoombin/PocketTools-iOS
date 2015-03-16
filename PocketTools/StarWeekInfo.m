//
//  StarNextInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarWeekInfo.h"

@implementation StarWeekInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.date = attributes[@"date"];
        self.weekth = attributes[@"weekth"];
        self.health = attributes[@"health"];
        self.job = attributes[@"job"];
        self.love = attributes[@"love"];
        self.money = attributes[@"money"];
        self.work = attributes[@"work"];
        self.resultcode = attributes[@"resultcode"];
        self.error_code = attributes[@"error_code"];
    }
    return self;
}
@end
