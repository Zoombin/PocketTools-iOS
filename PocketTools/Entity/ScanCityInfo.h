//
//  ScanCityInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ScanCityInfo : ZBModel
//"_id": 859,
//"cityName": "阜宁县",
//"lat": 33.759325,
//"lng": 119.802529,
//"provinceId": 32
@property (nonatomic, strong) NSNumber *cid;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;
@property (nonatomic, strong) NSNumber *provinceId;
+ (NSArray *)initWithArray:(NSArray *)array;
@end
