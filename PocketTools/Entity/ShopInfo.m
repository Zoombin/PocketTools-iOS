//
//  ShopInfo.m
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ShopInfo.h"

@implementation ShopInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.shopName = attributes[@"shopname"];
        self.price = attributes[@"price"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *shops = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        ShopInfo *info = [[ShopInfo alloc] initWithAttributes:array[i]];
        [shops addObject:info];
    }
    return shops;
}
@end
