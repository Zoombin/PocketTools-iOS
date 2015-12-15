//
//  PhonePayViewController.m
//  PocketTools
//
//  Created by yc on 15-3-10.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PhonePayViewController.h"

@interface PhonePayViewController ()

@end

@implementation PhonePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"话费充值", nil);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://op.juhe.cn/ofpay/pay/recharge"]]];
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
