//
//  AppleDeviceIdSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppleDeviceIdSearchViewController : PTViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *snTextField;
@property (nonatomic, weak) IBOutlet UILabel *contentTextView;
@property (nonatomic, weak) IBOutlet UIButton *searchButton;
- (IBAction)searchButtonClicked:(id)sender;
@end
