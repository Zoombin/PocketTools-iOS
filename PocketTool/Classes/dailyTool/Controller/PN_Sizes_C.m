//
//  PN_Sizes_C.m
//  PocketTool
//
//  Created by Mac on 15-2-9.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Sizes_C.h"

@interface PN_Sizes_C ()
@property (nonatomic,strong) UIImageView *backImage;
@end

@implementation PN_Sizes_C

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"尺码对照表";
    //设置背景
    self.backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.backImage.image = [UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:self.backImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changebg:) name:@"changebg" object:nil];
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
//更换背景
- (void)changebg:(NSNotification *)Notification
{
    self.backImage.image = (UIImage *)Notification.object;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
