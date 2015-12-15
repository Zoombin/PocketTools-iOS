//
//  PlaneInfo.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface PlaneInfo : ZBModel

@property (nonatomic, strong) NSString *FlightNum;
@property (nonatomic, strong) NSString *AirlineCode;
@property (nonatomic, strong) NSString *Airline;
@property (nonatomic, strong) NSString *DepCity;
@property (nonatomic, strong) NSString *ArrCity;
@property (nonatomic, strong) NSString *DepCode;
@property (nonatomic, strong) NSString *ArrCode;
@property (nonatomic, strong) NSString *OnTimeRate;
@property (nonatomic, strong) NSString *DepTerminal;
@property (nonatomic, strong) NSString *ArrTerminal;
@property (nonatomic, strong) NSString *FlightDate;
@property (nonatomic, strong) NSString *PEKDate;
@property (nonatomic, strong) NSString *DepTime;
@property (nonatomic, strong) NSString *ArrTime;
@property (nonatomic, strong) NSString *Dexpected;
@property (nonatomic, strong) NSString *Aexpected;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
