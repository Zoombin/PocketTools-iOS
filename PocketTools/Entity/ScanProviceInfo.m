//
//  ScanProviceInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ScanProviceInfo.h"

@implementation ScanProviceInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.pid = attributes[@"_id"];
        self.name = attributes[@"name"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *pArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        ScanProviceInfo *info = [[ScanProviceInfo alloc] initWithAttributes:array[i]];
        [pArray addObject:info];
    }
    return pArray;
}
@end
