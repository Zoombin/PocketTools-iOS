//
//  WZDetailInfo.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface WZDetailInfo : ZBModel

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *act;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *fen;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *handled;

+ (NSArray *)initWithArray:(NSArray *)arr;
@end
