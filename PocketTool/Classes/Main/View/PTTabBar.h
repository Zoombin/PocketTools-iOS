//
//  PTTabBar.h
//  PocketTool
//
//  Created by zhangbin on 2/15/15.
//  Copyright (c) 2015 PN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PTTabBarDelegate <NSObject>

- (void)ptTabBarSelectedAtIndex:(NSInteger)index;

@end

@interface PTTabBar : UIView

@property (nonatomic, weak) id <PTTabBarDelegate> delegate;

+ (CGFloat)height;

@end
