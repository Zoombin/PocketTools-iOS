//
//  StarYearInfo.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarYearInfo.h"

@implementation StarYearInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.career = attributes[@"career"];
        self.date = attributes[@"date"];
        self.error_code = attributes[@"error_code"];
        self.finance = attributes[@"finance"];
        self.future = attributes[@"future"];
        self.health = attributes[@"health"];
        self.love = attributes[@"love"];
        self.luckyStone = attributes[@"luckyStone"];
        self.mima = attributes[@"mima"];
        self.resultcode = attributes[@"resultcode"];
        self.year = attributes[@"year"];
    }
    return self;
}
@end
