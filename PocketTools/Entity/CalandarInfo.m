//
//  CalandarInfo.m
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CalandarInfo.h"

@implementation CalandarInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.id = attributes[@"id"];
        self.yangli = attributes[@"yangli"];
        self.yinli = attributes[@"yinli"];
        self.wuxing = attributes[@"wuxing"];
        self.chongsha = attributes[@"chongsha"];
        self.baiji = attributes[@"baiji"];
        self.jishen = attributes[@"jishen"];
        self.yi = attributes[@"yi"];
        self.xiongshen = attributes[@"xiongshen"];
        self.ji = attributes[@"ji"];
    }
    return self;
}
@end
