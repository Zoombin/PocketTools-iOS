//
//  StoreViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/21.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *normalImage = [UIImage imageNamed:@"99store"];
        UIImage *selectedImage = [UIImage imageNamed:@"99store_sel"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
//        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//        self.navigationItem.titleView = titleImageView;
        self.title = @"99工具";
        self.tabBarItem.title = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
