//
//  StationCell.h
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StationCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *stationDescribe;
@property (nonatomic, weak) IBOutlet UILabel *fseartLabel;
@property (nonatomic ,weak) IBOutlet UILabel *sseartLabel;
@end
