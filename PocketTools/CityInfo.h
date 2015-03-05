//
//  CityInfo.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface CityInfo : ZBModel
//abbr = "\U6d59";
//"city_code" = "ZJ_CXX";
//"city_name" = "\U957f\U5174\U53bf";
//class = 1;
//classa = 1;
//classno = 6;
//engine = 0;
//engineno = 0;
//regist = 0;
//registno = 0;
@property (nonatomic, strong) NSString *abbr;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *class;
@property (nonatomic, strong) NSString *classa;
@property (nonatomic, strong) NSString *classno;
@property (nonatomic, strong) NSString *engine;
@property (nonatomic, strong) NSString *engineno;
@property (nonatomic, strong) NSString *regist;
@property (nonatomic, strong) NSString *registno;

+(NSArray *)initWithArray:(NSArray *)arr;
@end
