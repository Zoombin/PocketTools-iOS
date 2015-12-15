//
//  ServiceResult.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface ServiceResult : ZBModel
@property (nonatomic, assign) NSNumber *error_code;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSDictionary *result;
@property (nonatomic, assign) NSNumber *resultcode;

@end
