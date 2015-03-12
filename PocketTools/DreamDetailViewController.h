//
//  DreamDetailViewController.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamDetailViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) NSString *content;
@end
