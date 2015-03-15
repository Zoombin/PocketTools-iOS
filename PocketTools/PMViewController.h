//
//  PMViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMCitySelectViewController.h"

@interface PMViewController : UIViewController<CitySelectDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *nowLabel;
@property (nonatomic, weak) IBOutlet UILabel *nowPMLabel;
@end
