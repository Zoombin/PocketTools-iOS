//
//  ScanProviceInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ScanProviceInfo : ZBModel

@property (nonatomic, strong) NSNumber *pid;
@property (nonatomic, strong) NSString *name;
+ (NSArray *)initWithArray:(NSArray *)array;
@end
