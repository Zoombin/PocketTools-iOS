//
//  PackageSearchViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageSearchViewController : PTViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UITextField *codeTextField;
- (IBAction)searchButtonClicked:(id)sender;
@end
