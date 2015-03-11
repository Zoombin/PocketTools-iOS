//
//  MovieInfo.h
//  PocketTools
//
//  Created by 颜超 on 15/3/11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface MovieInfo : ZBModel
//"rid":"1",
//"name":"中国合伙人",
//"wk":"2013.5.20--2013.5.26（单位：人民币）",
//"wboxoffice":"￥20900万",
//"tboxoffice":"￥31700万"
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
