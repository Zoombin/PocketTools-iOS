//
//  PTIndexView.m
//  PocketTool
//
//  Created by zhangbin on 2/15/15.
//  Copyright (c) 2015 PN. All rights reserved.
//

#import "PTIndexView.h"

@interface PTIndexView ()

@property (readwrite) UILabel *label;

@end

@implementation PTIndexView

+ (CGFloat)height {
	return 30;
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		_label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 10)];
		_label.font = [UIFont boldSystemFontOfSize:13];
		_label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_label];
	}
	return self;
}

- (void)setTitle:(NSString *)title {
	_title = title;
	_label.text = _title;
}

- (void)setColor:(UIColor *)color {
	_color = color;
	self.backgroundColor = _color;
	_label.backgroundColor = _color;
	_label.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected {
	_selected = selected;
	if (_selected) {
		_label.backgroundColor = [UIColor grayColor];
		_label.textColor = [UIColor blackColor];
	} else {
		_label.backgroundColor = _color;
		_label.textColor = [UIColor whiteColor];
	}
}



@end
