//
//  IDCardInfo.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "IDCardInfo.h"

@implementation IDCardInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.area = attributes[@"area"];
        self.sex = attributes[@"sex"];
        self.birthday = attributes[@"birthday"];
    }
    return self;
}
@end
