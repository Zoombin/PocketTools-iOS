//
//  TrainInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "TrainInfo.h"

@implementation TrainInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.start = attributes[@"start"];
        self.end = attributes[@"end"];
        self.starttime = attributes[@"starttime"];
        self.endtime = attributes[@"endtime"];
        self.mileage = attributes[@"mileage"];
    }
    return self;
}
@end
