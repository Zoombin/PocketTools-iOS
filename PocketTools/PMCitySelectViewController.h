//
//  PMCitySelectViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CitySelectDelegate <NSObject>
- (void)selectCityName:(NSString *)cityName;
@end

@interface PMCitySelectViewController : PTViewController

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<CitySelectDelegate> delegate;

@end
