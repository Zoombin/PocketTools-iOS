//
//  PTTabBar.m
//  PocketTool
//
//  Created by zhangbin on 2/15/15.
//  Copyright (c) 2015 PN. All rights reserved.
//

#import "PTTabBar.h"
#import "PTIndexView.h"

@interface PTTabBar ()

@property (readwrite) PTIndexView *toolsView;
@property (readwrite) PTIndexView *servicesView;
@property (readwrite) PTIndexView *readView;
@property (readwrite) PTIndexView *mallView;

@end


@implementation PTTabBar

+ (CGFloat)height {
	return 30;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		CGFloat width = self.bounds.size.width / 4;
		CGRect rect = CGRectZero;
		rect.size.width = width;
		rect.size.height = self.bounds.size.height;
		
		_toolsView = [[PTIndexView alloc] initWithFrame:rect];
		_toolsView.title = @"日常工具";
		_toolsView.color = [UIColor greenColor];
		_toolsView.tag = 0;
		[self addSubview:_toolsView];
		
		rect.origin.x = CGRectGetMaxX(_toolsView.frame);
		_servicesView = [[PTIndexView alloc] initWithFrame:rect];
		_servicesView.title = @"生活服务";
		_servicesView.color = [UIColor blueColor];
		_servicesView.tag = 1;
		[self addSubview:_servicesView];
		
		rect.origin.x = CGRectGetMaxX(_servicesView.frame);
		_readView = [[PTIndexView alloc] initWithFrame:rect];
		_readView.title = @"阅读发现";
		_readView.color = [UIColor orangeColor];
		_readView.tag = 2;
		[self addSubview:_readView];
		
		rect.origin.x = CGRectGetMaxX(_readView.frame);
		_mallView = [[PTIndexView alloc] initWithFrame:rect];
		_mallView.title = @"口袋商城";
		_mallView.color = [UIColor redColor];
		_mallView.tag = 3;
		[self addSubview:_mallView];
		
		UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
		[_toolsView addGestureRecognizer:tap1];
		[_servicesView addGestureRecognizer:tap2];
		[_readView addGestureRecognizer:tap3];
		[_mallView addGestureRecognizer:tap4];
	}
	return self;
}

- (void)tapped:(UITapGestureRecognizer *)tap {
	_toolsView.selected = NO;
	_servicesView.selected = NO;
	_readView.selected = NO;
	_mallView.selected = NO;
	PTIndexView *indexView = (PTIndexView *)tap.view;
	indexView.selected = YES;
	if (_delegate) {
		[_delegate ptTabBarSelectedAtIndex:indexView.tag];
	}
}

@end
