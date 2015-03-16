//
//  MoneyEntity.h
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface MoneyEntity : ZBModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fBuyPri;
@property (nonatomic, strong) NSString *mBuyPri;
@property (nonatomic, strong) NSString *fSellPri;
@property (nonatomic, strong) NSString *mSellPri;
@property (nonatomic, strong) NSString *bankConversionPri;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong)  NSString *cn;
@property (nonatomic, strong)  NSString *code;
@property (nonatomic, strong)  NSString *sign;
@end
