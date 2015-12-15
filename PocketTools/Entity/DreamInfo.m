//
//  DreamInfo.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "DreamInfo.h"

@implementation DreamInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.id = attributes[@"id"];
        self.title = attributes[@"title"];
        self.des = attributes[@"des"];
        self.list = attributes[@"list"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *dreams = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        DreamInfo *dreamInfo = [[DreamInfo alloc] initWithAttributes:array[i]];
        [dreams addObject:dreamInfo];
    }
    return dreams;
}
@end
