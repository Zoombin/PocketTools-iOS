//
//  ServiceRequest.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ServiceRequest.h"
#import "JHAPISDK.h"
#import "JHOpenidSupplier.h"

@implementation ServiceRequest

#define BASE_URL  @"http://apis.juhe.cn"

static AFHTTPRequestOperationManager *manager;
static ServiceRequest *request;

+ (instancetype)shared {
    if (!request) {
        request = [[ServiceRequest alloc] init];
        [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH3d10c81c2da5d095c11b5537360a47ac"];
        manager = [AFHTTPRequestOperationManager manager];
    }
    return request;
}

//获取&保存城市名称
- (void)saveCityName:(NSString *)cityName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault setObject:cityName forKey:CITY_NAME];
}

- (NSString *)getCityName {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:CITY_NAME];
}

//获取&保存天气信息
- (void)saveWeather:(NSDictionary *)info {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault setObject:info forKey:WEATHER_INFO];
}

- (NSDictionary *)getWeather {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:WEATHER_INFO];
}

//获取&保存3小时信息
- (void)saveThreeWeather:(NSArray *)array {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault setObject:array forKey:THREE_HOUR];
}

- (NSArray *)getThreeWeather {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:THREE_HOUR];
}

//获取&保存PM信息
- (void)savePMInfo:(NSDictionary *)info {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault setObject:info forKey:PM_VALUE];
}

- (NSDictionary *)getPMinfo {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:PM_VALUE];
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

- (void)saveBackGround:(NSString *)name {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:name forKey:BACKGROUND];
    [userDefault synchronize];
}

- (NSString *)getBackground {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *background = [userDefault objectForKey:BACKGROUND];
    return background == nil ? @"background1" : background;
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
    NSString *requestUrl = @"http://apis.juhe.cn/appleinfo/index";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"37" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//电话查询
- (void)phoneSearch:(NSString *)phoneNum
          withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"phone"] = phoneNum;
    NSString *requestUrl = @"http://apis.juhe.cn/mobile/get";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"11" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//聊天机器人
- (void)chatWithRobot:(NSString *)content
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"info"] = content;
    NSString *requestUrl = @"http://op.juhe.cn/robot/index";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"112" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//汇率计算
- (void)exchangeList:(void (^)(NSDictionary *, NSError *))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://web.juhe.cn:8080/finance/exchange/rmbquot";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"23" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//获取支持的城市列表
- (void)loadAllSupportCities:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://v.juhe.cn/wz/citys";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"36" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//获取车辆类型
- (void)loadCarTypesList:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://v.juhe.cn/wz/hpzl";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"36" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
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
    NSString *requestUrl = @"http://v.juhe.cn/wz/query";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"36" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//快递查询
- (void)postmanSearch:(NSString *)postman
              postnum:(NSString *)postnum
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"com"] = postman;
    params[@"no"] = postnum;
    NSString *requestUrl = @"http://v.juhe.cn/exp/index";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"43" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)dreamTypeList:(NSString *)fid
            withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    if (fid) {
        params[@"fid"] = fid;
    }
    NSString *requestUrl = @"http://v.juhe.cn/dream/category";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"64" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)dreamDetail:(NSString *)did
          withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"id"] = did;
    NSString *requestUrl = @"http://v.juhe.cn/dream/queryid";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"64" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)searchDreamByKey:(NSString *)kword
               withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"q"] = [kword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    params[@"full"] = @(1);
    NSString *requestUrl = @"http://v.juhe.cn/dream/query";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"64" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)goodsSearchWithNum:(NSString *)num
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"pkg"] = @"com.koudai";
    params[@"barcode"] = num;
    params[@"cityid"] = @"1";
    NSString *requestUrl = @"http://api.juheapi.com/jhbar/bar";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"52" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//最新票房
- (void)newestMovieRank:(NSString *)area
              withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"area"] = area;
    NSString *requestUrl = @"http://v.juhe.cn/boxoffice/rank";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"44" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//网票票房
- (void)netBuyMoiveWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://v.juhe.cn/boxoffice/wp";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"44" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//附近油价
- (void)nearByOilPrice:(NSNumber *)lon
                   lat:(NSNumber *)lat
             withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"lon"] = lon;
    params[@"lat"] = lat;
    NSString *requestUrl = @"http://apis.juhe.cn/oil/local";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"7" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//航线查询
- (void)planceSearch:(NSString *)startCity
             endCity:(NSString *)endCity
           withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"start"] = startCity;
    params[@"end"] = endCity;
    NSString *requestUrl = @"http://apis.juhe.cn/plan/bc";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"20" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

//老黄历
- (void)laohuangli:(NSString *)date
         withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"date"] = date;
    NSString *requestUrl = @"http://v.juhe.cn/laohuangli/d";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"65" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)trainTimesSearch:(NSString *)trainName
               withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"name"] = trainName;
    NSString *requestUrl = @"http://apis.juhe.cn/train/s";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"22" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)searchTrainByStart:(NSString *)start
                       end:(NSString *)end
                 trainType:(NSString *)type
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"start"] = start;
    params[@"end"] = end;
    if (type) {
        params[@"traintype"] = type;
    }
    NSString *requestUrl = @"http://apis.juhe.cn/train/s2s";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"22" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)loadPMCityListWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://web.juhe.cn:8080/environment/air/pmCities";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"33" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)loadAirCityListWithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    NSString *requestUrl = @"http://v.juhe.cn/weather/citys";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"39" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)searchPM25ByCity:(NSString *)city
               WithBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"city"] = city;
    NSString *requestUrl = @"http://web.juhe.cn:8080/environment/air/pm";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"33" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)searchAirByCity:(NSString *)city
              withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"city"] = city;
    NSString *requestUrl = @"http://web.juhe.cn:8080/environment/air/cityair";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"33" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)searchStarLuckByName:(NSString *)name
                        type:(NSString *)type
                   withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"consName"] = name;
    params[@"type"] = type;
//    运势类型：today,tomorrow,week,nextweek,month,year
    NSString *requestUrl = @"http://web.juhe.cn:8080/constellation/getAll";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"58" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)threeHour:(NSString *)city
        withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"cityname"] = city;
    NSString *requestUrl = @"http://v.juhe.cn/weather/forecast3h";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"39" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}

- (void)getWeatherByIdOrName:(NSString *)name
                   withBlock:(void (^)(NSDictionary *result, NSError *error))block {
    NSMutableDictionary *params =  [self getRequestParams];
    params[@"cityname"] = name;
    NSString *requestUrl = @"http://v.juhe.cn/weather/index";
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:requestUrl APIID:@"39" Parameters:params Method:@"GET" Success:^(id responseObject) {
        block(responseObject, nil);
    } Failure:^(NSError *error) {
        block(nil, error);
    }];
}
@end
