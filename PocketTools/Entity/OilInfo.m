//
//  OilInfo.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "OilInfo.h"

@implementation OilInfo
- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.id = attributes[@"id"];
        self.name = attributes[@"name"];
        self.areaname = attributes[@"areaname"];
        self.address = attributes[@"address"];
        self.brandname = attributes[@"brandname"];
        self.type = attributes[@"type"];
        self.discount = attributes[@"discount"];
        self.exhaust = attributes[@"exhaust"];
        self.position = attributes[@"position"];
        self.lon = attributes[@"lon"];
        self.lat = attributes[@"lat"];
        self.price = attributes[@"price"];
        self.gastprice = attributes[@"gastprice"];
        self.fwlsmc = attributes[@"fwlsmc"];
        self.distance = attributes[@"distance"];
    }
    return self;
}

+ (NSArray *)initWithArray:(NSArray *)array {
    NSMutableArray *oils = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        OilInfo *oilInfo = [[OilInfo alloc] initWithAttributes:array[i]];
        [oils addObject:oilInfo];
    }
    return oils;
}
//"id": "34299",
//"name": "中油燕宾北邮加油站‎（办卡优惠）",
//"area": "chongwen",
//"areaname": "北京市 崇文区",
//"address": "北京市崇文区天坛路12号，与东市场东街路交叉西南角（天坛北门往西一公里路南）。",
//"brandname": "中石油",
//"type": "加盟店",
//"discount": "打折加油站",
//"exhaust": "京Ⅴ",
//"position": "116.401654,39.886973",
//"lon": "116.40804671453",
//"lat": "39.893324983272",
//"price": [
//          {
//              "type": "E90",
//              "price": "7.31"
//          },
//          {
//              "type": "E93",
//              "price": "6.92"
//          },
//          {
//              "type": "E97",
//              "price": "7.36"
//          },
//          {
//              "type": "E0",
//              "price": "6.84"
//          }
//          ],
//"gastprice": [
//              {
//                  "name": "92#",
//                  "price": "6.77"
//              },
//              {
//                  "name": "95#",
//                  "price": "7.36"
//              }
//              ],
//"fwlsmc": "银联卡,信用卡支付",
//"distance": 2564
//},
@end
