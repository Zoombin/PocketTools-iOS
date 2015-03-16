//
//  GoodsInfo.h
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface GoodsInfo : ZBModel

@property (nonatomic, strong) NSString *barcode;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSNumber *shopNum;
@property (nonatomic, strong) NSNumber *eshopNum;
@property (nonatomic, strong) NSString *interval;
@end
