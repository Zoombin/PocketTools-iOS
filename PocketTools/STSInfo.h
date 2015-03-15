//
//  STSInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface STSInfo : ZBModel
//"trainOpp": "G104",
//"train_typename": "高铁",
//"start_staion": "上海虹桥",
//"end_station": "苏州北",
//"leave_time": "07:10",
//"arrived_time": "07:33",
//"mileage": "81"
@property (nonatomic, strong) NSString *trainOpp;
@property (nonatomic, strong) NSString *train_typename;
@property (nonatomic, strong) NSString *start_staion;
@property (nonatomic, strong) NSString *end_station;
@property (nonatomic, strong) NSString *leave_time;
@property (nonatomic, strong) NSString *arrived_time;
@property (nonatomic, strong) NSString *mileage;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
