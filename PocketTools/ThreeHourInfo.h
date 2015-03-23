//
//  ThreeHourInfo.h
//  PocketTools
//
//  Created by yc on 15-3-23.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ThreeHourInfo : ZBModel
//"weatherid": "00",/*天气标识ID*/
//"weather": "晴", /*天气*/
//"temp1": "27", /*低温*/
//"temp2": "31", /*高温*/
//"sh": "08", /*开始小时*/
//"eh": "11", /*结束小时*/
//"date": "20140530", /*日期*/
//"sfdate": "20140530080000", /*完整开始时间*/
//"efdate": "20140530110000" /*完整结束时间*/
@property (nonatomic, strong) NSString *weatherid;
@property (nonatomic, strong) NSString *weather;
@property (nonatomic, strong) NSString *temp1;
@property (nonatomic, strong) NSString *temp2;
@property (nonatomic, strong) NSString *sh;
@property (nonatomic, strong) NSString *eh;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *sfdate;
@property (nonatomic, strong) NSString *efdate;

+ (NSArray *)initWithArray:(NSArray *)array;
@end
