//
//  ScanCityListViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScanCityDelegate <NSObject>
- (void)selectedCityId:(NSNumber *)cid;

@end
@interface ScanCityListViewController : PTViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, weak) id<ScanCityDelegate> delegate;
@end
