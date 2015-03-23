//
//  ViewController.h
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *tmptureLabel;
@property (nonatomic, weak) IBOutlet UIView *weatherView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *weatherLabel;

@property (nonatomic, weak) IBOutlet UILabel *lowLabel;
@property (nonatomic, weak) IBOutlet UILabel *highLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *futureWeatherScrollView;
@end

