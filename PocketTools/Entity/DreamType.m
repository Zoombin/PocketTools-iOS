//
//  DreamType.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "DreamType.h"

@implementation DreamType

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.id = attributes[@"id"];
        self.name = attributes[@"name"];
        self.fid = attributes[@"fid"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *typeArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        DreamType *type = [[DreamType alloc] initWithAttributes:array[i]];
        [typeArray addObject:type];
    }
    return typeArray;
}
@end
