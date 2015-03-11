//
//  GoodsInfo.h
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface GoodsInfo : ZBModel
//"barcode": "6923450605332",
//"name": "绿箭无糖薄荷糖(冰柠薄荷味35粒铁盒装23.8g)",
//"imgurl": "",
//"shopNum": 13,
//"eshopNum": 3,
//"interval": "￥:3.4 ~ ￥:10.2"
@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSNumber *shopNum;
@property (nonatomic, strong) NSNumber *eshopNum;
@property (nonatomic, strong) NSString *interval;
@end
