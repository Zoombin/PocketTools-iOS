//
//  CarType.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CarType.h"

@implementation CarType

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.car = attributes[@"car"];
        self.carId = attributes[@"id"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)arr {
    NSMutableArray *types = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        CarType *type = [[CarType alloc] initWithAttributes:arr[i]];
        [types addObject:type];
    }
    return types;
}
@end
