//
//  ViewController.h
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "GDTSplashAd.h"

@interface MainViewController : PTViewController <UIScrollViewDelegate, UIActionSheetDelegate, CLLocationManagerDelegate, GDTSplashAdDelegate> {
    GDTSplashAd *_splash;
}


@property (nonatomic, weak) IBOutlet UIView *starView;
@property (nonatomic, weak) IBOutlet UIButton *healthBtn;
@property (nonatomic, weak) IBOutlet UIButton *loveBtn;
@property (nonatomic, weak) IBOutlet UIButton *moneyBtn;
@property (nonatomic, weak) IBOutlet UIButton *workBtn;
@property (nonatomic, weak) IBOutlet UILabel *currentRateLabel;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, weak) IBOutlet UIButton *currentStarBtn;

@property (nonatomic, weak) IBOutlet UILabel *cityLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UILabel *tmptureLabel;
@property (nonatomic, weak) IBOutlet UIView *weatherView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UILabel *weatherLabel;

@property (nonatomic, weak) IBOutlet UILabel *lowLabel;
@property (nonatomic, weak) IBOutlet UILabel *highLabel;
@property (nonatomic, weak) IBOutlet UIScrollView *futureWeatherScrollView;
@property (nonatomic, weak) IBOutlet UILabel *pmLabel;
@property (nonatomic, weak) IBOutlet UILabel *pmDesLabel;
@property (nonatomic, weak) IBOutlet UILabel *pmtitleLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *loadingView;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

