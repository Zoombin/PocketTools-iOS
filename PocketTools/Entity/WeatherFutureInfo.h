//
//  WeatherFutureInfo.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface WeatherFutureInfo : ZBModel

@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSDictionary *weather_id;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
