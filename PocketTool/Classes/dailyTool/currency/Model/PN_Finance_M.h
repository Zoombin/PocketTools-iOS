//
//  PN_Finance_M.h
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PN_Finance_M : NSObject
/**
 *  货币名称
 */
@property (nonatomic,copy) NSString *name;
/**
 *  中行折算价
 */
@property (nonatomic,copy) NSString *bankConversionPri;
///*
// name":"英镑", 				 /*货币名称*/
//"fBuyPri":"1001.430", 			 /*现汇买入价*/
//"mBuyPri":"970.510", 			 /*现钞买入价*/
//"fSellPri":"1009.480", 			 /*现汇卖出价*/
//"mSellPri":"1009.480", 			 /*现钞卖出价*/
//"bankConversionPri":"1014.870",		 /*中行折算价*/
//"date":"2012-12-13",	   		 /*发布日期*/
//"time":"16:25:49"  			 /*发布时间*/
// */

@end
