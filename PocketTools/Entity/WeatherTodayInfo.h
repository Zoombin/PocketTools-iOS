//
//  WeatherTodayInfo.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface WeatherTodayInfo : ZBModel

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *date_y;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSDictionary *weather_id;
@property (nonatomic, strong) NSString *wind;
@property (nonatomic, strong) NSString *dressing_index;
@property (nonatomic, strong) NSString *dressing_advice;
@property (nonatomic, strong) NSString *uv_index;
@property (nonatomic, strong) NSString *comfort_index;
@property (nonatomic, strong) NSString *wash_index;
@property (nonatomic, strong) NSString *travel_index;
@property (nonatomic, strong) NSString *exercise_index;
@property (nonatomic, strong) NSString *drying_index;
@end
