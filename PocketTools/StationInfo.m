//
//  StationInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StationInfo.h"

@implementation StationInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.train_id = attributes[@"train_id"];
        self.station_name = attributes[@"station_name"];
        self.arrived_time = attributes[@"arrived_time"];
        self.leave_time = attributes[@"leave_time"];
        self.mileage = attributes[@"mileage"];
        self.fsoftSeat = attributes[@"fsoftSeat"];
        self.ssoftSeat = attributes[@"ssoftSeat"];
        self.hardSead = attributes[@"hardSead"];
        self.softSeat = attributes[@"softSeat"];
        self.softSleep = attributes[@"softSleep"];
        self.hardSleep = attributes[@"hardSleep"];
        self.wuzuo = attributes[@"wuzuo"];
        self.swz = attributes[@"swz"];
        self.tdz = attributes[@"tdz"];
        self.gjrw = attributes[@"gjrw"];
        self.stay = attributes[@"stay"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *stations = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        StationInfo *info = [[StationInfo alloc] initWithAttributes:array[i]];
        [stations addObject:info];
    }
    return stations;
}
@end
