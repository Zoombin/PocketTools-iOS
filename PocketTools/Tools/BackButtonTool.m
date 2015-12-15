//
//  UIViewController+Button.m
//  PocketTools
//
//  Created by yc on 15-3-19.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "BackButtonTool.h"

@implementation BackButtonTool

+ (void)addBackButton:(UIViewController *)viewCtrl {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:viewCtrl.navigationController action:@selector(popViewControllerAnimated:)];
    viewCtrl.navigationItem.leftBarButtonItem = backItem;
}
@end
