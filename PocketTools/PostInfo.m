//
//  PostInfo.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PostInfo.h"

@implementation PostInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.datetime = attributes[@"datetime"];
        self.zone = attributes[@"zone"];
        self.remark = attributes[@"remark"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *postInfos = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        PostInfo *info = [[PostInfo alloc] initWithAttributes:array[i]];
        [postInfos addObject:info];
    }
    return postInfos;
}
@end
