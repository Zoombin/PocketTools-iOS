//
//  BallView
//  Tools
//
//  Created by 颜超 on 15/3/27.
//  Copyright (c) 2015年 颜超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallView : UIButton {

}
@property (nonatomic, assign) float per;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *color;
- (void)reDraw;
@end
