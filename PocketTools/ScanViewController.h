//
//  ScanViewController.h
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface ScanViewController : PTViewController<ZBarReaderViewDelegate, ZBarReaderDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIImageView *iconImageView;
@property (nonatomic, weak) IBOutlet UITextView *contenTextView;
@end
