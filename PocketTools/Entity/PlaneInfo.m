//
//  PlaneInfo.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PlaneInfo.h"

@implementation PlaneInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.FlightNum = attributes[@"FlightNum"];
        self.AirlineCode = attributes[@"AirlineCode"];
        self.Airline = attributes[@"Airline"];
        self.DepCity = attributes[@"DepCity"];
        self.ArrCity = attributes[@"ArrCity"];
        self.DepCode = attributes[@"DepCode"];
        self.OnTimeRate = attributes[@"OnTimeRate"];
        self.DepTerminal = attributes[@"DepTerminal"];
        self.ArrTerminal = attributes[@"ArrTerminal"];
        self.FlightDate = attributes[@"FlightDate"];
        self.PEKDate = attributes[@"PEKDate"];
        self.DepTime = attributes[@"DepTime"];
        self.ArrTime = attributes[@"ArrTime"];
        self.Dexpected = attributes[@"Dexpected"];
        self.Aexpected = attributes[@"Aexpected"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *planesArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        PlaneInfo *planeInfo = [[PlaneInfo alloc] initWithAttributes:array[i]];
        [planesArray addObject:planeInfo];
    }
    return planesArray;
}
@end
