//
//  PN_Package_C.m
//  PocketTool
//
//  Created by Mac on 15-2-11.
//  Copyright (c) 2015年 PN. All rights reserved.
//
#define magin 10

#import "PN_Package_C.h"

@interface PN_Package_C ()

@end

@implementation PN_Package_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册ID
    JUHE;
    
    //标题
    self.title = @"快递查询";
    
    //返回按钮
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    //快递公司数组
    NSArray *arr = @[@"EMS",@"顺丰",@"申通",@"圆通",@"韵达",@"天天",@"中通",@"汇通"];
    NSArray *arrnum = @[@"ems",@"sf",@"sto",@"yt",@"yd",@"tt",@"zto",@"ht"];
    
    //创建快递公司按钮
    for (int i=0; i<2; i++) {
        for (int j=0; j<4; j++) {
            CGFloat btnW = (mainW-(8*magin))/4;
            CGFloat btnX = (j*btnW)+(magin*(j+1)+magin);
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(btnX, i*44+(magin*(i+1))+64, btnW, 44)];
            int k = j;
            if (i==1) {
                k=j+4;
            }
            [btn setTitle:arr[k] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            
            [self.view addSubview:btn];
        }
    }
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}


@end
