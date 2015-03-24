//
//  PhoneSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneSearchViewController : PTViewController

@property (nonatomic, weak) IBOutlet UITextField *phoneTextField;
@property (nonatomic, weak) IBOutlet UILabel *contentTextView;
@property (nonatomic, weak) IBOutlet UIButton *searchButton;
- (IBAction)searchButtonClicked:(id)sender;
@end
