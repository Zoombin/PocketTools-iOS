//
//  StarCurrentInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarCurrentInfo.h"

@implementation StarCurrentInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.date = attributes[@"date"];
        self.all = attributes[@"all"];
        self.color = attributes[@"color"];
        self.health = attributes[@"health"];
        self.love = attributes[@"love"];
        self.money = attributes[@"money"];
        self.number = attributes[@"number"];
        self.QFriend = attributes[@"QFriend"];
        self.summary = attributes[@"summary"];
        self.work = attributes[@"work"];
        self.error_code = attributes[@"error_code"];
    }
    return self;
}
@end
