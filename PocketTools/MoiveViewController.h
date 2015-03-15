//
//  MoiveViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoiveViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *allSegmetedControl;
@property (nonatomic, strong) IBOutlet UISegmentedControl *areaSegmetedControl;
@end