//
//  PhoneInfo.h
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface PhoneInfo : ZBModel

@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *areacode;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *card;
@end
