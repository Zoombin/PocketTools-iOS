//
//  AboutUSViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/12/14.
//  Copyright © 2015年 yc. All rights reserved.
//

#import "AboutUSViewController.h"

@interface AboutUSViewController ()

@end

@implementation AboutUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zoombin.github.io/PocketTools-Web/"]]];
    // Do any additional setup after loading the view from its nib.
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
