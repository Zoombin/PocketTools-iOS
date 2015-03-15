//
//  TrainInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface TrainInfo : ZBModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *start;
@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *starttime;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *mileage;


//"train_info": {
//    "name": "G656",
//    "start": "西安北",
//    "end": "北京西",
//    "starttime": "10:10",
//    "endtime": "16:27",
//    "mileage": "1212km"
//},
//"station_list": [
//                 {
//                     "train_id": "1",
//                     "station_name": "西安北",
//                     "arrived_time": "-",
//                     "leave_time": "10:10",
//                     "mileage": "-",
//                     "fsoftSeat": "-",
//                     "ssoftSeat": "-",
//                     "hardSead": "-",
//                     "softSeat": "-",
//                     "hardSleep": "-",
//                     "softSleep": "-",
//                     "wuzuo": "-",
//                     "swz": "-",
//                     "tdz": "-",
//                     "gjrw": "-",
//                     "stay": "-"
//                 },
@end
