//
//  ShopInfo.h
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ShopInfo : ZBModel

@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSNumber *price;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
