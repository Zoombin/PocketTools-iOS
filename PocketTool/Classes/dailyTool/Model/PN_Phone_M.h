//
//  PN_Phone_M.h
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//  电话号码归属度返回数据模型

#import <Foundation/Foundation.h>

@interface PN_Phone_M : NSObject
/**
 *  省份
 */
@property (nonatomic,copy) NSString *province;
/**
 *  城市
 */
@property (nonatomic,copy) NSString *city;
/**
 *  区号
 */
@property (nonatomic,copy) NSString *areacode;
/**
 *  邮编
 */
@property (nonatomic,copy) NSString *zip;
/**
 *  运营商
 */
@property (nonatomic,copy) NSString *company;
/**
 *  卡类型
 */
@property (nonatomic,copy) NSString *card;
@end
