//
//  WZInfo.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface WZInfo : ZBModel

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *carNum;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSArray *lists;


@end
