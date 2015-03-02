//
//  AppInfoEntity.h
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ZBModel.h"

@interface AppInfoEntity : ZBModel

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *controlName;
@property (nonatomic, strong) NSString *iconName;
+ (NSMutableArray *)initWithArray:(NSArray *)infoArray;
@end
