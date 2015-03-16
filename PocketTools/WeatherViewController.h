//
//  WeatherViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCitiesViewController.h"

@interface WeatherViewController : UIViewController <CitySelectDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImg;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIView *firstView;
@property (nonatomic, weak) IBOutlet UILabel *temLabel;
@property (nonatomic, weak) IBOutlet UILabel *temRangeLabel;

@property (nonatomic, weak) IBOutlet UIView *secondView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *weatherLabel;
@property (nonatomic, weak) IBOutlet UILabel *windLabel;
@property (nonatomic, weak) IBOutlet UILabel *windLocationLabel;
@property (nonatomic, weak) IBOutlet UILabel *wetLabel;

@property (nonatomic, weak) IBOutlet UIView *thirdView;
@property (nonatomic, weak) IBOutlet UILabel *thirdContentTextView;
@property (nonatomic, weak) IBOutlet UILabel *fLabel;
@property (nonatomic, weak) IBOutlet UILabel *sLabel;
@property (nonatomic, weak) IBOutlet UILabel *tLabel;
@property (nonatomic, weak) IBOutlet UILabel *ffLabel;

@property (nonatomic, weak) IBOutlet UIView *fourView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end
