//
//  AppDelegate.h
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
     BMKMapManager* _mapManager;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;

- (void)initTabBar;
@end

