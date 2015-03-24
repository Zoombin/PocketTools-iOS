//
//  PlaneSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaneSearchViewController : PTViewController

@property (nonatomic, weak) IBOutlet UITextField *startTextField;
@property (nonatomic, weak) IBOutlet UITextField *endTextField;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *headerView;
- (IBAction)sureButtonClicked:(id)sender;
@end
