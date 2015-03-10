//
//  TicketsViewController.m
//  PocketTools
//
//  Created by yc on 15-3-10.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "TicketsViewController.h"

@interface TicketsViewController ()

@end

@implementation TicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"彩票", nil);
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://touch.lecai.com/?noClientdl=1&agentId=3179#path=page%2Fmain"]]];
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
