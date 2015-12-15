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
@end
