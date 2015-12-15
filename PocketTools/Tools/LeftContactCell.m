//
//  LeftContactCell.m
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "LeftContactCell.h"

@implementation LeftContactCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getHeight {
    CGFloat height = CGRectGetMaxY(_backgroundImage.frame) + 20;
    if (height > 80) {
        return height;
    }
    return 80;
}
@end
