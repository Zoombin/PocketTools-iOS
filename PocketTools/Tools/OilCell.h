//
//  OilCell.h
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OilCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *addressLabel;
@property (nonatomic, weak) IBOutlet UILabel *fpriceTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *fpriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *spriceTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *spriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *tpriceTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *tpriceLabel;
@property (nonatomic, weak) IBOutlet UILabel *distanceLabel;
@property (nonatomic, weak) IBOutlet UILabel *tagLabel;
@end
