//
//  UnitInfo.h
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface UnitInfo : ZBModel

@property (nonatomic, strong) NSString *text;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) double value;
@end
