//
//  PMViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PMCitySelectViewController.h"

@interface PMViewController : PTViewController <CitySelectDelegate, CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *nowLabel;
@property (nonatomic, weak) IBOutlet UILabel *nowDesLabel;
@property (nonatomic, weak) IBOutlet UITextField *pm25ValueLabel;
@property (nonatomic, weak) IBOutlet UITextField *pmValueLabel;
@property (nonatomic, weak) IBOutlet UITextField *so2ValueLabel;
@property (nonatomic, weak) IBOutlet UITextField *no2ValueLabel;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
