//
//  PlaneCell.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaneInfo.h"

@interface PlaneCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *fightNumLabel;
@property (nonatomic, weak) IBOutlet UILabel *depTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *arrTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *depLabel;
@property (nonatomic, weak) IBOutlet UILabel *arrLabel;
@property (nonatomic, weak) IBOutlet UILabel *airLineLabel;
@end
