//
//  MoneyEntity.h
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface MoneyEntity : ZBModel
//"name":"英镑", 				 /*货币名称*/
//"fBuyPri":"1001.430", 			 /*现汇买入价*/
//"mBuyPri":"970.510", 			 /*现钞买入价*/
//"fSellPri":"1009.480", 			 /*现汇卖出价*/
//"mSellPri":"1009.480", 			 /*现钞卖出价*/
//"bankConversionPri":"1014.870",		 /*中行折算价*/
//"date":"2012-12-13",	   		 /*发布日期*/
//"time":"16:25:49"  			 /*发布时间*/
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fBuyPri;
@property (nonatomic, strong) NSString *mBuyPri;
@property (nonatomic, strong) NSString *fSellPri;
@property (nonatomic, strong) NSString *mSellPri;
@property (nonatomic, strong) NSString *bankConversionPri;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *time;
//	  cn,CNY,¥
@property (nonatomic, strong)  NSString *cn;
@property (nonatomic, strong)  NSString *code;
@property (nonatomic, strong)  NSString *sign;
@end
