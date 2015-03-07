//
//  DreamType.h
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface DreamType : ZBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fid;
+ (NSArray *)initWithArray:(NSArray *)array;
@end
