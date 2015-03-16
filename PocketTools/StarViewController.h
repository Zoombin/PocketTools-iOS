//
//  StarViewController.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarSelectViewController.h"

@interface StarViewController : UIViewController <StarSelectDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, weak) IBOutlet UILabel *describeLabel;
@property (nonatomic, weak) IBOutlet UIButton *iconButton;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel1;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel2;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel3;
@property (nonatomic, weak) IBOutlet UITextView *dayContentTextView;

@end
