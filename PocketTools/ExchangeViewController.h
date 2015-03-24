//
//  ExchangeViewController.h
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeViewController : PTViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIView *inputView;
- (IBAction)sureButtonClicked:(id)sender;
@end
