//
//  CalandarInfo.h
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface CalandarInfo : ZBModel
//"id": "1657",
//"yangli": "2014-09-11",
//"yinli": "甲午(马)年八月十八",
//"wuxing": "井泉水 建执位",
//"chongsha": "冲兔(己卯)煞东",
//"baiji": "乙不栽植千株不长 酉不宴客醉坐颠狂",
//"jishen": "官日 六仪 益後 月德合 除神 玉堂 鸣犬",
//"yi": "祭祀 出行 扫舍 馀事勿取",
//"xiongshen": "月建 小时 土府 月刑 厌对 招摇 五离",
//"ji": "诸事不宜"
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *yangli;
@property (nonatomic, strong) NSString *yinli;
@property (nonatomic, strong) NSString *wuxing;
@property (nonatomic, strong) NSString *chongsha;
@property (nonatomic, strong) NSString *baiji;
@property (nonatomic, strong) NSString *jishen;
@property (nonatomic, strong) NSString *yi;
@property (nonatomic, strong) NSString *xiongshen;
@property (nonatomic, strong) NSString *ji;
@end
