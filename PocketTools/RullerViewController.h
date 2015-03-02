//
//  RullerViewController.h
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RullerViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *rullerButton;
@property (nonatomic, weak) IBOutlet UIButton *backButton;
@property (nonatomic, assign) BOOL btnStatus;
@property (nonatomic, strong) UIImage *btnImagecm;
@property (nonatomic, strong) UIImage *btnImageinch;

- (IBAction)btnclick:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
@end
