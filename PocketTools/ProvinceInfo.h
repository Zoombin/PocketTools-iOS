//
//  ProvinceInfo.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ProvinceInfo : ZBModel

@property (nonatomic, strong) NSArray *citys;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *provinceCode;
@end
