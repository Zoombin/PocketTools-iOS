//
//  MoneyEntity.m
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MoneyEntity.h"

@implementation MoneyEntity

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.name = attributes[@"name"];
        self.fBuyPri = attributes[@"fBuyPri"];
        self.mBuyPri = attributes[@"mBuyPri"];
        self.fSellPri = attributes[@"fSellPri"];
        self.mSellPri = attributes[@"mSellPri"];
        self.bankConversionPri = attributes[@"bankConversionPri"];
        self.date = attributes[@"date"];
        self.time = attributes[@"time"];
    }
    return self;
}
@end
