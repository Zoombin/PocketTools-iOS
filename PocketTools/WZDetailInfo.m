//
//  WZDetailInfo.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WZDetailInfo.h"

@implementation WZDetailInfo

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.date = attributes[@"date"];
        self.area = attributes[@"area"];
        self.act = attributes[@"act"];
        self.code = attributes[@"code"];
        self.fen = attributes[@"fen"];
        self.money = attributes[@"money"];
        self.handled = attributes[@"handled"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)arr {
    if (arr == nil) {
        return nil;
    }
    NSMutableArray *details = [NSMutableArray array];
    for (int i = 0; i < [arr count]; i++) {
        WZDetailInfo *info = [[WZDetailInfo alloc] initWithAttributes:arr[i]];
        [details addObject:info];
    }
    return details;
}
//                 {
//                     "date":"2013-12-29 11:57:29",
//                     "area":"316省道53KM+200M",
//                     "act":"16362 : 驾驶中型以上载客载货汽车、校车、危险物品运输车辆以外的其他机动车在高速公路以外的道路上行驶超过规定时速20%以上未达50%的",
//                     "code":"",
//                     "fen":"6",
//                     "money":"100",
//                     "handled":"0"
//                 }
@end
