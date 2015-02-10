//
//  PN_Ruler_C.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Ruler_C.h"

@interface PN_Ruler_C ()
//英尺公尺切换按钮
@property (weak,nonatomic) UIButton *button;
// 状态标识
@property (nonatomic, assign) BOOL btnStatus;
// 公尺图片
@property (nonatomic, strong) UIImage *btnImagecm;
// 英尺图片
@property (nonatomic, strong) UIImage *btnImageinch;
@end

@implementation PN_Ruler_C

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //英尺公尺切换按钮
    _btnImagecm = [UIImage imageNamed:@"btn_ruler_inch"];
    _btnImageinch = [UIImage imageNamed:@"btn_ruler_cm"];
    self.btnStatus = YES;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 50)];
    button.center = self.view.center;
    button.y = mainH*0.65;
    [button setImage:_btnImagecm forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(btnclick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    self.button = button;
    
    //返回按钮
   UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    back.center = self.view.center;
    back.y = mainH*0.8;
    [back setImage:[UIImage imageWithName:@"btn_ruler_close"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:back];
    
    //默认点击
    [self btnclick];
}

//英尺公尺切换按钮点击事件
- (void)btnclick
{
    if (self.btnStatus == YES) {
        [self.button setImage:_btnImagecm forState:UIControlStateNormal];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"gr_ruler_cm@2x"]];
    }
    else{
        [self.button setImage:_btnImageinch forState:UIControlStateNormal];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"gr_ruler_inch@2x"]];
    }
    self.btnStatus = !self.btnStatus;
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
