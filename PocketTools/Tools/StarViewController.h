//
//  StarViewController.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallView.h"
#import "StarSelectViewController.h"

@interface StarViewController : PTViewController <StarSelectDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, weak) IBOutlet UILabel *describeLabel;
@property (nonatomic, weak) IBOutlet UIButton *iconButton;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel1;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel2;
@property (nonatomic, weak) IBOutlet UILabel *dayLabel3;
@property (nonatomic, weak) IBOutlet UITextView *dayContentTextView;

@property (nonatomic, weak) IBOutlet BallView *firstButton;
@property (nonatomic, weak) IBOutlet BallView *secondButton;
@property (nonatomic, weak) IBOutlet BallView *thirdButton;
@property (nonatomic, weak) IBOutlet BallView *fourthButton;

@end
