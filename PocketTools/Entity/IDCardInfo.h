//
//  IDCardInfo.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface IDCardInfo : ZBModel

@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *birthday;

@end
