//
//  GamePayViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/9.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "GamePayViewController.h"

@interface GamePayViewController ()

@end

@implementation GamePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"游戏";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://wvs.m.taobao.com/game_card.htm?spm=0.0.0.0&sid=1c72ee52cc4ce9c966d24fa7c96e9841&pid=null&back_hidden_flag=null&pds=game%23h%23zhichong&type=2&unid=null"]]];
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
