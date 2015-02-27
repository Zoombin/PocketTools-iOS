//
//  AppleInfo.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "AppleInfo.h"

@implementation AppleInfo

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.active = attributes[@"active"];
        self.activeDate = attributes[@"active_date"];
        self.color = attributes[@"color"];
        self.endDate = attributes[@"end_date"];
        self.imeiNumber = attributes[@"imei_number"];
        self.madeArea = attributes[@"made_area"];
        self.phoneModel = attributes[@"phone_model"];
        self.serialNumber = attributes[@"serial_number"];
        self.size = attributes[@"size"];
        self.startDate = attributes[@"start_date"];
        self.teleSupport = attributes[@"tele_support"];
        self.teleSupportStatus = attributes[@"tele_support_status"];
        self.warranty = attributes[@"warranty"];
        self.warrantyStatus = attributes[@"warranty_status"];
    }
    return self;
}
@end
