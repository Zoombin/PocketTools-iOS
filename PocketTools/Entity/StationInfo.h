//
//  StationInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface StationInfo : ZBModel

@property (nonatomic, strong) NSString *train_id;
@property (nonatomic, strong) NSString *station_name;
@property (nonatomic, strong) NSString *arrived_time;
@property (nonatomic, strong) NSString *leave_time;
@property (nonatomic, strong) NSString *mileage;
@property (nonatomic, strong) NSString *fsoftSeat;
@property (nonatomic, strong) NSString *ssoftSeat;
@property (nonatomic, strong) NSString *hardSead;
@property (nonatomic, strong) NSString *softSeat;
@property (nonatomic, strong) NSString *softSleep;
@property (nonatomic, strong) NSString *hardSleep;
@property (nonatomic, strong) NSString *wuzuo;
@property (nonatomic, strong) NSString *swz;
@property (nonatomic, strong) NSString *tdz;
@property (nonatomic, strong) NSString *gjrw;
@property (nonatomic, strong) NSString *stay;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
