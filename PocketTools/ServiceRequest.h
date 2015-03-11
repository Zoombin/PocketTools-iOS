//
//  ServiceRequest.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "UserCarSearchInfo.h"

//#define APP_ID @"e2a4d76a04bc042a8b47045baf6c9873"
#define SUCCESS_CODE 200
#define DEVICE_ID @"device_id"
#define SEARCH_HISTORY @"search_history"
#define POSTMAN_HISTORY @"postman_history"
#define PHOTO_PASSWORD @"photo_password"
#define PHOTO_LIST @"photo_list"
#define NETWORK_ERROR @"网络异常"

@interface ServiceRequest : NSObject

- (void)saveAppID:(NSString *)appId;
- (void)saveUserSearch:(NSDictionary *)searchInfo;
- (NSArray *)getSearchHistory;

- (void)savePassword:(NSString *)hasSet;
- (NSString *)getPassword;

- (void)savePostManSearch:(NSDictionary *)searchInfo;
- (NSArray *)getPostManSearch;

- (NSString *)getAppId;

- (void)savePhotoName:(NSString *)photoName;
- (void)removePhotoName:(NSString *)photoName;
- (NSArray *)getPhotoList;

+ (instancetype)shared;

//获取苹果序列号信息
- (void)appleInfo:(NSString *)appid
        withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//身份证查询
- (void)idCardSearch:(NSString *)uid
           withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//IP查询
- (void)ipSearch:(NSString *)ip
       withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//电话查询
- (void)phoneSearch:(NSString *)phoneNum
          withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//聊天机器人
- (void)chatWithRobot:(NSString *)content
            withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//汇率换算
- (void)exchangeList:(void (^)(NSDictionary *result, NSError *error))block;

//车辆违章获取支持城市列表
- (void)loadAllSupportCities:(void (^)(NSDictionary *result, NSError *error))block;

//获取车辆类型列表
- (void)loadCarTypesList:(void (^)(NSDictionary *result, NSError *error))block;

//搜索违章
- (void)searchWZ:(NSString *)cityName
          carNum:(NSString *)cnum
         carType:(NSString *)carType
        carFrame:(NSString *)carFrameNum
       engineNum:(NSString *)engineNum
       registNum:(NSString *)registNum
       withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//快递查询
- (void)postmanSearch:(NSString *)postman
              postnum:(NSString *)postnum
            withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//梦的种类
- (void)dreamTypeList:(NSString *)fid
            withBlock:(void (^)(NSDictionary *result, NSError *error))block;

//搜索梦
- (void)searchDreamByKey:(NSString *)kword
               withBlock:(void (^)(NSDictionary *result, NSError *error))block;
//条码查询
- (void)goodsSearchWithNum:(NSString *)num
                 withBlock:(void (^)(NSDictionary *result, NSError *error))block;

@end
