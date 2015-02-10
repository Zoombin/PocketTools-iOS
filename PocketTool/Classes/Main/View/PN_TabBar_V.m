//
//  PN_TabBar_V.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_TabBar_V.h"

@interface PN_TabBar_V ()
@property (weak,nonatomic)UIButton *selectedButton;
@end
@implementation PN_TabBar_V

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建4个button
        //日常工具
        [self setupButtonWithTitle:@"日常工具" andbackgrandImage:@"btn_tab1" andSelectedImage:@"btn_tab1_select"];
        //生活服务
        [self setupButtonWithTitle:@"生活服务" andbackgrandImage:@"btn_tab2" andSelectedImage:@"btn_tab2_select"];
        //阅读发现
        [self setupButtonWithTitle:@"阅读发现" andbackgrandImage:@"btn_tab3" andSelectedImage:@"btn_tab3_select"];
        //口袋商城
        [self setupButtonWithTitle:@"口袋商城" andbackgrandImage:@"btn_tab4" andSelectedImage:@"btn_tab4_select"];
        
        //设置按钮位置
        [self setButtonframe];
}
    return self;
}

- (void)setupButtonWithTitle:(NSString *)title andbackgrandImage:(NSString *)image andSelectedImage:(NSString *)selectedimage
{
    UIButton *button = [[UIButton alloc] init];
    // 绑定tag
    button.tag = self.subviews.count;
    //设置图片和选中图片
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageWithName:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageWithName:selectedimage] forState:(UIControlStateSelected)];
    [button addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchDown)];
    [self addSubview:button];
}

/**
 *  设置button的位置
 */
- (void)setButtonframe
{
    NSInteger count = self.subviews.count;
    
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.width = mainW*0.25;
        button.height = mainH*0.05;
        button.x = i*(button.width);
        button.y = 0;
        //默认选中第0个
        if (i==0) {
            [self buttonclick:button];
        }
    }
}
/**
 *  监听按钮点击
 */
- (void)buttonclick:(UIButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.更改按钮状态
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}
@end
