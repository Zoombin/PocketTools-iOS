//
//  StarSelectViewController.h
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StarSelectDelegate <NSObject>
- (void)selectStarAtIndex:(NSInteger)index;
@end

@interface StarSelectViewController : PTViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<StarSelectDelegate> delegate;
@end
