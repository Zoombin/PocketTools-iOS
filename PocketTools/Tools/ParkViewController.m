//
//  ParkViewController.m
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ParkViewController.h"

@interface ParkViewController ()

@end

@implementation ParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"停车场";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://map.baidu.com/mobile/webapp/index/index#search/search/qt=s&wd=%E5%81%9C%E8%BD%A6%E5%9C%BA&c=224&searchFlag=bigBox&version=5&exptype=dep/vt="]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
