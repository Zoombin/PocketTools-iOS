//
//  MovieInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface MovieInfo : ZBModel

@property (nonatomic, strong) NSString *rid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *wk;
@property (nonatomic, strong) NSString *wboxoffice;
@property (nonatomic, strong) NSString *tboxoffice;

@property (nonatomic, strong) NSString *totals; //总场次
@property (nonatomic, strong) NSString *fare;
@property (nonatomic, strong) NSString *statistics;
@property (nonatomic, strong) NSString *averaging;
@property (nonatomic, strong) NSString *attendance;
@property (nonatomic, strong) NSString *people;
@property (nonatomic, strong) NSString *boxoffice;
+ (NSArray *)initWithArray:(NSArray *)array;
@end
