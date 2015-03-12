//
//  DreamInfo.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface DreamInfo : ZBModel

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *des;
@property (nonatomic, strong) NSArray *list;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
