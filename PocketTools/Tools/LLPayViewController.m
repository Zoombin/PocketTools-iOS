//
//  LLPayViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/9.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "LLPayViewController.h"

@interface LLPayViewController ()

@end

@implementation LLPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"流量充值";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://kdgj.liulianginn.com/koudai/index.html"]]];
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
