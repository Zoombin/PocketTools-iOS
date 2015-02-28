//
//  IPSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-2-28.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPSearchViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *ipTextField;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@end
