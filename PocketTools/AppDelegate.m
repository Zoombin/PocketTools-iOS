//
//  AppDelegate.m
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "AppDelegate.h"
#import "ReadingViewController.h"
#import "LifeViewController.h"
#import "DailyViewController.h"
#import "StoreViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:@"rt0EArVNsq8NNGjx49028hb1" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self initTabBar];
    return YES;
}

- (void)initTabBar {
    //日常工具
    UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:[DailyViewController new]];
    
    //生活服务
    UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:[LifeViewController new]];
    
    //充值服务
    UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:[ReadingViewController new]];
    
    //99商城
     UINavigationController *navigation4 = [[UINavigationController alloc] initWithRootViewController:[StoreViewController new]];
    
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController.tabBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]]];
    [self.tabBarController.tabBar setShadowImage:[self createImageWithColor:[UIColor clearColor]]];
    self.tabBarController.viewControllers = @[navigation1, navigation2, navigation3, navigation4];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
