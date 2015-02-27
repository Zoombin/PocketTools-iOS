//
//  AppleInfo.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface AppleInfo : ZBModel
@property (nonatomic, strong) NSString *active;
@property (nonatomic, strong) NSString *activeDate;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *madeArea;
@property (nonatomic, strong) NSString *imeiNumber;
@property (nonatomic, strong) NSString *phoneModel;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *teleSupport;
@property (nonatomic, strong) NSString *teleSupportStatus;
@property (nonatomic, strong) NSString *warranty;
@property (nonatomic, strong) NSString *warrantyStatus;

//"error_code" = 0;
//reason = Successed;
//result =     {
//    active = "\U5df2\U6fc0\U6d3b";
//    "active_date" = "2014-11-27";
//    color = "";
//    "end_date" = "2014-11-18";
//    "imei_number" = "";
//    "made_area" = "\U4e2d\U56fd";
//    "phone_model" = "iPhone 6";
//    "serial_number" = C39NP0KBG5MV;
//    size = "";
//    "start_date" = "2014-11-12";
//    "tele_support" = "";
//    "tele_support_status" = "\U5df2\U8fc7\U671f";
//    warranty = "2015-11-26";
//    "warranty_status" = "\U672a\U8fc7\U671f";
//};
//resultcode = 200;
@end
