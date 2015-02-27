//
//  AppleDeviceIdSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppleDeviceIdSearchViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *snTextField;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@end
