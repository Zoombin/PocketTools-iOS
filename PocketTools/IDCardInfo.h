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
//{
//    "resultcode":"200",
//    "reason":"成功的返回",
//    "result":{
//        "area":"浙江省温州市平阳县",
//        "sex":"男",
//        "birthday":"1989年03月08日"
//    }
//}
@end
