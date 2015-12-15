//
//  PostInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface PostInfo : ZBModel

@property (nonatomic, strong) NSString *datetime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *zone;
+ (NSArray *)initWithArray:(NSArray *)array;
@end
