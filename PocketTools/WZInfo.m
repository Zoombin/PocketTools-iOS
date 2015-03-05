//
//  WZInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WZInfo.h"
#import "WZDetailInfo.h"

@implementation WZInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.province = attributes[@"province"];
        self.cityCode = attributes[@"city"];
        self.carNum = attributes[@"hphm"];
        self.carType = attributes[@"hpzl"];
        self.lists = [WZDetailInfo initWithArray:attributes[@"lists"]];
    }
    return self;
}

//{
//    "resultcode":"200",
//    "reason":"查询成功",
//    "result":{
//        "province":"HB",
//        "city":"HB_HD",
//        "hphm":"冀DHL327",
//        "hpzl":"02",
//        "lists":[
//                 {
//                     "date":"2013-12-29 11:57:29",
//                     "area":"316省道53KM+200M",
//                     "act":"16362 : 驾驶中型以上载客载货汽车、校车、危险物品运输车辆以外的其他机动车在高速公路以外的道路上行驶超过规定时速20%以上未达50%的",
//                     "code":"",
//                     "fen":"6",
//                     "money":"100",
//                     "handled":"0"
//                 }
//                 ]
//    }
//}
@end
