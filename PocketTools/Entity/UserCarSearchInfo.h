//
//  UserCarSearchInfo.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface UserCarSearchInfo : ZBModel

@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *carFrameNum;
@property (nonatomic, strong) NSString *carNum;
@property (nonatomic, strong) NSString *carRegist;
@property (nonatomic, strong) NSString *carEngineNum;
@end
