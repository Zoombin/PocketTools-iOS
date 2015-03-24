//
//  BackgroundViewController.h
//  PocketTools
//
//  Created by yc on 15-3-24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundViewController : PTViewController

@property (nonatomic, weak) IBOutlet UIButton *button1;
@property (nonatomic, weak) IBOutlet UIButton *button2;
@property (nonatomic, weak) IBOutlet UIButton *button3;
- (IBAction)bkgButtonClicked:(id)sender;
@end
