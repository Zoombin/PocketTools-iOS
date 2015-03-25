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
#define  mainW [UIScreen mainScreen].bounds.size.width

@implementation RullerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //英尺公尺切换按钮
    _btnImagecm = [UIImage imageNamed:@"btn_ruler_inch"];
    _btnImageinch = [UIImage imageNamed:@"btn_ruler_cm"];
    self.btnStatus = YES;
    
    [_rullerButton setFrame:CGRectMake((mainW / 2) - _rullerButton.frame.size.width / 2, _rullerButton.frame.origin.y, _rullerButton.frame.size.width, _rullerButton.frame.size.height)];
    [_backButton setFrame:CGRectMake((mainW / 2) - _backButton.frame.size.width / 2, _backButton.frame.origin.y, _backButton.frame.size.width, _backButton.frame.size.height)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self btnclick:nil];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)btnclick:(id)sender
{
    if (self.btnStatus == YES) {
        [self.rullerButton setImage:_btnImagecm forState:UIControlStateNormal];
        _imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gr_ruler_cm"]];
    }
    else{
        [self.rullerButton setImage:_btnImageinch forState:UIControlStateNormal];
        _imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gr_ruler_inch"]];
    }
    self.btnStatus = !self.btnStatus;
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
