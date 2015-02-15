//
//  PN_Exchange_M.h
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PN_Exchange_M : NSObject
/**
 *  货币名称
 */
@property (nonatomic,copy) NSString *currency;
/**
 *  货币代码
 */
@property (nonatomic,copy) NSString *code;
/**
 *  最新价
 */
@property (nonatomic,copy) NSString *closePri;
@end
