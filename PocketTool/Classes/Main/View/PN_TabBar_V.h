//
//  PN_TabBar_V.h
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PN_TabBar_V;
@protocol PNTabBarDelegate <NSObject>
- (void)tabBar:(PN_TabBar_V *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end
@interface PN_TabBar_V : UIView
//- (void)setSelectedIndex:(NSUInteger)index;

@property (nonatomic, weak) id<PNTabBarDelegate> delegate;
@end
