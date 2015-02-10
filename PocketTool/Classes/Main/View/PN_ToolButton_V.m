//
//  PN_ToolButton_V.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//
// 图标的比例
#define PNToolButtonImageRatio 0.6

#import "PN_ToolButton_V.h"

@implementation PN_ToolButton_V

- (id)initWithTitle:(NSString *)title andImage:(NSString *)image andTarget:(id)target action:(SEL)action
{
    if (self = [super init]) {
        //设定尺寸
        self.frame = CGRectMake(0, 0, mainW*0.25, mainW*0.25);
        
        //设定边框
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [[UIColor darkGrayColor]CGColor];
        
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        // 设置文字
        [self setTitle:title forState:UIControlStateNormal];
        // 文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        // 设置图片
        [self setImage:[UIImage imageWithName:image] forState:UIControlStateNormal];
        
        [self addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    }
    return self;
}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * PNToolButtonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * PNToolButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}
@end
