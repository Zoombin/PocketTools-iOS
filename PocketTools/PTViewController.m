//
//  PTViewController.m
//  PocketTools
//
//  Created by yc on 15-3-24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([[ServiceRequest shared] getBackground]) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[[ServiceRequest shared] getBackground]]]];
    }
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
