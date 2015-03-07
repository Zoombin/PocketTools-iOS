//
//  DreamListViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DreamListViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *searchTextField;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end
