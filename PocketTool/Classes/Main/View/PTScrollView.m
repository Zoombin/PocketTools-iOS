//
//  PTScrollView.m
//  PocketTool
//
//  Created by zhangbin on 2/15/15.
//  Copyright (c) 2015 PN. All rights reserved.
//

#import "PTScrollView.h"

static NSInteger const numberPerLine = 4;
static NSInteger const numberOfLine = 2;
static NSInteger const numberPerPage = numberPerLine * numberOfLine;

@implementation PTScrollView

- (void)setElements:(NSArray *)elements {
	_elements = elements;
	CGRect rect = CGRectZero;
	CGFloat width = self.bounds.size.width / numberPerLine;
	CGFloat height = self.bounds.size.height / numberOfLine;
	rect.size.width = width;
	rect.size.height = height;
	for (int i = 0; i < _elements.count;) {
		UIButton *button = _elements[i];
		button.frame = rect;
		[self addSubview:button];
		i++;
		if (i % (numberPerLine * numberOfLine) == 0) {
			rect.origin.x = self.bounds.size.width * (_elements.count / numberPerPage);
			rect.origin.y = 0;
		} else if (i % numberPerLine == 0) {
			rect.origin.x = 0;
			rect.origin.y = height;
		} else {
			rect.origin.x += width;
		}
	}
	
	self.contentSize = CGSizeMake(self.bounds.size.width * (_elements.count / (numberPerLine * numberOfLine) + 1), self.bounds.size.height);
}

@end
