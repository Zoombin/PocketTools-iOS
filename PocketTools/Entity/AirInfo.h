//
//  AirInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface AirInfo : ZBModel
//"city": "苏州",  /*城市*/
//"PM2.5": "73",  /*PM2.5指数*/
//"AQI": "98",    /*空气质量指数*/
//"quality": "良", /*空气质量*/
//"PM10": "50",/*PM10*/
//"CO": "0.79",  /*一氧化碳*/
//"NO2": "65",  /*二氧化氮*/
//"O3": "28",    /*臭氧*/
//"SO2": "41",  /*二氧化硫*/
//"time": "2014-12-26 11:48:40"/*更新时间*/
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *PM25;
@property (nonatomic, strong) NSString *AQI;
@property (nonatomic, strong) NSString *quality;
@property (nonatomic, strong) NSString *PM10;
@property (nonatomic, strong) NSString *CO;
@property (nonatomic, strong) NSString *NO2;
@property (nonatomic, strong) NSString *O3;
@property (nonatomic, strong) NSString *SO2;
@property (nonatomic, strong) NSString *time;
@end
