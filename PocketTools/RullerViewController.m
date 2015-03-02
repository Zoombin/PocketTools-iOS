//
//  RullerViewController.m
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "RullerViewController.h"

@interface RullerViewController ()

@end

#define  mainH [UIScreen mainScreen].bounds.size.height

@implementation RullerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //英尺公尺切换按钮
    _btnImagecm = [UIImage imageNamed:@"btn_ruler_inch"];
    _btnImageinch = [UIImage imageNamed:@"btn_ruler_cm"];
    self.btnStatus = YES;
    [self btnclick:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)btnclick:(id)sender
{
    if (self.btnStatus == YES) {
        [self.rullerButton setImage:_btnImagecm forState:UIControlStateNormal];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gr_ruler_cm"]];
    }
    else{
        [self.rullerButton setImage:_btnImageinch forState:UIControlStateNormal];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gr_ruler_inch"]];
    }
    self.btnStatus = !self.btnStatus;
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
