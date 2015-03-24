//
//  TrainViewController.h
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainViewController : PTViewController <UISearchBarDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *titleSegmentedControl;
@property (nonatomic, strong) IBOutlet UIView *firstHeader;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITextField *startTextField;
@property (nonatomic, weak) IBOutlet UITextField *endTextField;
@property (nonatomic, weak) IBOutlet UIButton *trainTypeBtn;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
- (IBAction)trainTypeButtonClicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
@end
