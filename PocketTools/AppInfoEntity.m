//
//  AppInfoEntity.m
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "AppInfoEntity.h"

@implementation AppInfoEntity

- (id)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (self) {
        self.appName = attributes[@"appName"];
        self.controlName = attributes[@"controlName"];
        self.iconName = attributes[@"iconName"];
    }
    return self;
}

+ (NSMutableArray *)initWithArray:(NSArray *)infoArray {
    NSMutableArray *appArray = [NSMutableArray array];
    for (int i = 0; i < [infoArray count]; i++) {
        AppInfoEntity *entity = [[AppInfoEntity alloc] initWithAttributes:infoArray[i]];
        [appArray addObject:entity];
    }
    return appArray;
}
@end
