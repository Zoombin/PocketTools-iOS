//
//  WeatherCurrentInfo.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface WeatherCurrentInfo : ZBModel

@property (nonatomic, strong) NSString *temp;
@property (nonatomic, strong) NSString *wind_direction;
@property (nonatomic, strong) NSString *wind_strength;
@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *time;
@end
