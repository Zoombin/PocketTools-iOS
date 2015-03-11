//
//  GoodsInfo.m
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "GoodsInfo.h"

@implementation GoodsInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.barcode = attributes[@"barcode"];
        self.name = attributes[@"name"];
        self.imgurl = attributes[@"imgurl"];
        self.eshopNum = attributes[@"eshopNum"];
        self.shopNum = attributes[@"shopNum"];
        self.interval = attributes[@"interval"];
    }
    return self;
}
@end
