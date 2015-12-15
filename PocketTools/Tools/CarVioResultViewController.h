//
//  CarVioResultViewController.h
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarVioResultViewController : PTViewController

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *carNum;
@property (nonatomic, strong) NSString *carType;
@property (nonatomic, strong) NSString *carFrameNum;
@property (nonatomic, strong) NSString *engineNum;
@property (nonatomic, strong) NSString *registNum;
@end
