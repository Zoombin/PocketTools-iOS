//
//  OilInfo.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface OilInfo : ZBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *areaname;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *brandname;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *exhaust;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSDictionary *price;
@property (nonatomic, strong) NSDictionary *gastprice;
@property (nonatomic, strong) NSString *fwlsmc;
@property (nonatomic, strong) NSNumber *distance;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
