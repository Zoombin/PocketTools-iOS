//
//  IPInfo.m
//  PocketTools
//
//  Created by yc on 15-2-28.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "IPInfo.h"

@implementation IPInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.area = attributes[@"area"];
        self.location = attributes[@"location"];
    }
    return self;
}
@end
