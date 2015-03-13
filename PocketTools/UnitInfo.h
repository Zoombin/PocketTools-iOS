//
//  UnitInfo.h
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface UnitInfo : ZBModel
//    localp1.index = 100;
//    localp1.text = "米";
//    localp1.value = 1.0D;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) double value;
@end
