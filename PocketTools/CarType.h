//
//  CarType.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface CarType : ZBModel

@property (nonatomic, strong) NSString *car;
@property (nonatomic, strong) NSString *carId;

+ (NSArray *)initWithArray:(NSArray *)arr;
@end
