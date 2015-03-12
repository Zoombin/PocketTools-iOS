//
//  ServiceRequest.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ServiceRequest.h"

@implementation ServiceRequest

#define BASE_URL  @"http://apis.juhe.cn"

static AFHTTPRequestOperationManager *manager;
static ServiceRequest *request;

+ (instancetype)shared {
    if (!request) {
        request = [[ServiceRequest alloc] init];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return request;
}

- (void)saveUserSearch:(NSDictionary *)searchInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *historyArray = [userDefault objectForKey:SEARCH_HISTORY];
    if (historyArray == nil) {
        NSArray *newArray = @[searchInfo];
        [userDefault setObject:newArray forKey:SEARCH_HISTORY];
        [userDefault synchronize];
    } else {
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:historyArray];
        [oldArray addObject:searchInfo];
        [userDefault setObject:oldArray forKey:SEARCH_HISTORY];
        [userDefault synchronize];
    }
}

- (NSArray *)getSearchHistory {
     NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
     NSArray *historyArray = [userDefault objectForKey:POSTMAN_HISTORY];
    return historyArray;
}

- (void)savePassword:(NSString *)hasSet {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:hasSet forKey:PHOTO_PASSWORD];
    [userDefault synchronize];
}

- (NSString *)getPassword
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:PHOTO_PASSWORD];
}

- (void)savePostManSearch:(NSDictionary *)searchInfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *historyArray = [userDefault objectForKey:POSTMAN_HISTORY];
    if (historyArray == nil) {
        NSArray *newArray = @[searchInfo];
        [userDefault setObject:newArray forKey:POSTMAN_HISTORY];
        [userDefault synchronize];
    } else {
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:historyArray];
        [oldArray addObject:searchInfo];
        [userDefault setObject:oldArray forKey:POSTMAN_HISTORY];
        [userDefault synchronize];
    }
}

- (NSArray *)getPostManSearch {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *historyArray = [userDefault objectForKey:POSTMAN_HISTORY];
    return historyArray;
}

- (void)saveAppID:(NSString *)appId {
    if ([appId isEqualToString:@""]) {
        return;
    }
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:appId forKey:DEVICE_ID];
    [userDefault synchronize];
}

- (NSString *)getAppId {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:DEVICE_ID];
}

//----------相册-------------
- (void)savePhotoName:(NSString *)photoName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *historyArray = [userDefault objectForKey:PHOTO_LIST];
    if (historyArray == nil) {
        NSArray *newArray = @[photoName];
        [userDefault setObject:newArray forKey:PHOTO_LIST];
        [userDefault synchronize];
    } else {
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:historyArray];
        [oldArray addObject:photoName];
        [userDefault setObject:oldArray forKey:PHOTO_LIST];
        [userDefault synchronize];
    }
}
- (void)removePhotoName:(NSString *)photoName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *historyArray = [userDefault objectForKey:PHOTO_LIST];
    if (historyArray == nil) {
        return;
    } else {
        NSMutableArray *oldArray = [NSMutableArray arrayWithArray:historyArray];
        if ([oldArray containsObject:photoName]) {
            [oldArray removeObject:photoName];
        }
        [userDefault setObject:oldArray forKey:PHOTO_LIST];
        [userDefault synchronize];
    }

}
- (NSArray *)getPhotoList {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSArray *photoList = [userDefault objectForKey:PHOTO_LIST];
    return photoList;
}
//----------相册-------------

- (NSMutableDictionary *)getRequestParams {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"dtype"] = @"json";
    return params;
}

//获取苹果序列号信息
- (void)appleInfo:(NSString *)appid withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"sn"] = appid;
    params[@"key"] = @"e2a4d76a04bc042a8b47045baf6c9873";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/appleinfo/index", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)idCardSearch:(NSString *)uid
           withBlocl:(void (^)(NSDictionary *result, NSError *error))block
{
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"cardno"] = uid;
    params[@"key"] = @"51431019e527a0cd73e5daf157348e84";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/idcard/index", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//IP查询
- (void)ipSearch:(NSString *)ip
       withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"ip"] = ip;
    params[@"key"] = @"07710610d64e235e50b257308b2aea76";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/ip/ip2addr", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//电话查询
- (void)phoneSearch:(NSString *)phoneNum
          withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"phone"] = phoneNum;
    params[@"key"] = @"b8b61acf82e1866e41a67c53e295f51b";
    NSString *requestUrl = [NSString stringWithFormat:@"%@/mobile/get", BASE_URL];
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//聊天机器人
- (void)chatWithRobot:(NSString *)content
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"info"] = content;
    params[@"key"] = @"39ded27a75232bba451702ab705faeea";
    NSString *requestUrl = @"http://op.juhe.cn/robot/index";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//汇率计算
- (void)exchangeList:(void (^)(NSDictionary *, NSError *))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"ecfbba891b63a81c297ec1afb690d5ad";
    NSString *requestUrl = @"http://web.juhe.cn:8080/finance/exchange/rmbquot";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%ld", (long)operation.response.statusCode);
        if (operation.response.statusCode == 200) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
            block(jsonDict, nil);
            return;
        }
        block(nil, error);
    }];
}

//获取支持的城市列表
- (void)loadAllSupportCities:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"e4ff4be7d2b4e89b3df1cbdd08fcb67e";
    NSString *requestUrl = @"http://v.juhe.cn/wz/citys";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//获取车辆类型
- (void)loadCarTypesList:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"e4ff4be7d2b4e89b3df1cbdd08fcb67e";
    NSString *requestUrl = @"http://v.juhe.cn/wz/hpzl";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//搜索违章
- (void)searchWZ:(NSString *)cityName
          carNum:(NSString *)cnum
         carType:(NSString *)carType
        carFrame:(NSString *)carFrameNum
       engineNum:(NSString *)engineNum
       registNum:(NSString *)registNum
       withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"city"] = cityName;
    params[@"hphm"] = cnum;
    params[@"hpzl"] = carType;
    if (carFrameNum) {
        params[@"classno"] = carFrameNum;
    }
    if (engineNum) {
        params[@"engineno"] = engineNum;
    }
    if (registNum) {
        
    }
    params[@"key"] = @"e4ff4be7d2b4e89b3df1cbdd08fcb67e";
    NSString *requestUrl = @"http://v.juhe.cn/wz/query";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//快递查询
- (void)postmanSearch:(NSString *)postman
              postnum:(NSString *)postnum
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"9b5b7b0a8edf2102283955ffba0f29fe";
    params[@"com"] = postman;
    params[@"no"] = postnum;
    NSString *requestUrl = @"http://v.juhe.cn/exp/index";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)dreamTypeList:(NSString *)fid
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"e10ef3445ac25e570094dcf48bece26a";
    if (fid) {
        params[@"fid"] = fid;
    }
    NSString *requestUrl = @"http://v.juhe.cn/dream/category";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)dreamDetail:(NSString *)did
          withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"e10ef3445ac25e570094dcf48bece26a";
    params[@"id"] = did;
    NSString *requestUrl = @"http://v.juhe.cn/dream/queryid";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)searchDreamByKey:(NSString *)kword
               withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"e10ef3445ac25e570094dcf48bece26a";
    params[@"q"] = [kword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"full"] = @(1);
    NSString *requestUrl = @"http://v.juhe.cn/dream/query";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

- (void)goodsSearchWithNum:(NSString *)num
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"appkey"] = @"aceec7d212876cc985b310d694725f78";
    params[@"pkg"] = @"com.koudai";
    params[@"barcode"] = num;
    params[@"cityid"] = @"1";
    NSString *requestUrl = @"http://api.juheapi.com/jhbar/bar";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%ld", (long)operation.response.statusCode);
        if (operation.response.statusCode == 200) {
            NSLog(@"%@", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                                     options:NSJSONReadingMutableContainers
                                                                       error:nil];
            block(jsonDict, nil);
            return;
        }
        block(nil, error);
    }];
}

//最新票房
- (void)newestMovieRank:(NSString *)area
              withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"77ec98fa45a52fc1385c29c80e841f9b";
    params[@"area"] = area;
    NSString *requestUrl = @"http://v.juhe.cn/boxoffice/rank";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//网票票房
- (void)netBuyMoiveWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"77ec98fa45a52fc1385c29c80e841f9b";
    NSString *requestUrl = @"http://v.juhe.cn/boxoffice/wp";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}

//附近油价
- (void)nearByOilPrice:(NSNumber *)lon
                   lat:(NSNumber *)lat
             withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"key"] = @"d6733f4e3f60dbd00de2cfb6feb6e28d";
    params[@"lon"] = lon;
    params[@"lat"] = lat;
    NSString *requestUrl = @"http://apis.juhe.cn/oil/local";
    [manager GET:requestUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        block(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
}


@end
