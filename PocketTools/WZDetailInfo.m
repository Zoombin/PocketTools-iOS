//
//  WZDetailInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WZDetailInfo.h"

@implementation WZDetailInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.date = attributes[@"date"];
        self.area = attributes[@"area"];
        self.act = attributes[@"act"];
        self.code = attributes[@"code"];
        self.fen = attributes[@"fen"];
        self.money = attributes[@"money"];
        self.handled = attributes[@"handled"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)arr {
    if (arr == nil) {
        return nil;
    }
    NSMutableArray *details = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        WZDetailInfo *info = [[WZDetailInfo alloc] initWithAttributes:arr[i]];
        [details addObject:info];
    }
    return details;
}
@end
