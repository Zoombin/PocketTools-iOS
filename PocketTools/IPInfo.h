//
//  IPInfo.h
//  PocketTools
//
//  Created by yc on 15-2-28.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface IPInfo : ZBModel
//{
//    "resultcode":"200",
//    "reason":"Return Successd!",
//    "result":{
//        "area":"江苏省苏州市",
//        "location":"电信"
//    }
//}
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *location;
@end
