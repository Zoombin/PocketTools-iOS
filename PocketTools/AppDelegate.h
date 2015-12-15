//
//  AppDelegate.h
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
#import "GDTSplashAd.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, GDTSplashAdDelegate> {
     BMKMapManager* _mapManager;
     GDTSplashAd *spashAd;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

