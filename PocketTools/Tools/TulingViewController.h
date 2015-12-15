//
//  TulingViewController.h
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TulingViewController : PTViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
- (IBAction)sendButto:(id)sender;
@end
