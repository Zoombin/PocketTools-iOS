//
//  SizesViewController.m
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "SizesViewController.h"

@interface SizesViewController ()

@end

@implementation SizesViewController

#define  mainH [UIScreen mainScreen].bounds.size.height
#define  mainW [UIScreen mainScreen].bounds.size.width

//懒加载
- (NSMutableArray *)viewArr
{
    if (_viewArr == nil) {
        self.viewArr = [NSMutableArray array];
    }
    return _viewArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"尺码对照表";
    //设置背景
    self.backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.backImage];
    
    //创建尺码图数组
    NSArray *ImageArr1 = @[@"women_shoes",@"women_shirt",@"women_dress",@"women_pants",@"women_underwear",@"women_bra"];
    NSArray *ImageArr2 = @[@"men_shoes",@"men",@"men_shirt",@"men_suit",@"men_pants",@"men_underwear"];
    NSArray *IMageArr3 =@[@"kids_shoes",@"kids"];
    self.ImageArr = @[ImageArr1,ImageArr2,IMageArr3];
    
    //创建服装数组
    NSArray *fuzhuangArr1 = @[@"女鞋",@"衬衫",@"连衣裙",@"裤子",@"内裤",@"文胸"];
    NSArray *fuzhuangArr2 = @[@"男鞋",@"上衣",@"衬衫",@"西装",@"裤子",@"内裤"];
    NSArray *fuzhuangArr3 = @[@"童鞋",@"童装"];
    NSArray *fuzhuangArr = @[fuzhuangArr1,fuzhuangArr2,fuzhuangArr3];
    
    //创建scrollView
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 138, mainW, mainH-138)];
    self.sizeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainW, 200)];
    [self.scroll addSubview:self.sizeImage];
    [self.view addSubview:self.scroll];
    
    //创建选择的三个按钮
    NSArray *chouseArr = @[@"女装",@"男装",@"童装"];
    for (int i=0; i<chouseArr.count; i++) {
        //创建按钮
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*(mainW/3), 64, mainW/3, 44)];
        btn.tag = i;
        [btn setTitle:chouseArr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_passnum_dn"] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(chouseClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:btn];
        
        //创建view
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 108, mainW, 30)];
        NSArray *temp =fuzhuangArr[i];
        int count = (int)temp.count;
        for (int j=0; j<count; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(j*(mainW/count), 0, mainW/count, 30)];
            if (i==chouseArr.count-1) {//童装视图
                CGRect frame = btn.frame;
                frame.size.width = mainW/6;
                frame.origin.x = (j+2)*(mainW/6);
                btn.frame = frame;
            }
            btn.tag = ((i+1)*10)+j;
            [btn setTitle:temp[j] forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_search_select"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(fuzhuangClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [view addSubview:btn];
        }
        [self.viewArr addObject:view];
        if (i==0) {
            [self chouseClick:btn];
        }
    }
    
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
//选择按钮的点击事件
- (void)chouseClick:(UIButton *)btn
{
    //改变按钮状态
    self.oldchouseBtn.selected = NO;
    btn.selected = YES;
    self.oldchouseBtn = btn;
    
    if (self.fuzhuangView) {
        //如果之前有 移除
        [self.fuzhuangView removeFromSuperview];
        self.fuzhuangView = nil;
    }
    self.num = (int)btn.tag;
    self.fuzhuangView = self.viewArr[btn.tag];
    [self.view addSubview:self.fuzhuangView];
    
    UIButton *button =(UIButton *)[self.view viewWithTag:(btn.tag+1)*10];
    [self fuzhuangClick:button];
}
//服装按钮的点击事件（切换尺码表）
- (void)fuzhuangClick:(UIButton *)btn
{
    //改变按钮状态
    self.oldsizeBtn.selected = NO;
    btn.selected = YES;
    self.oldsizeBtn = btn;
    
    NSArray *arr = self.ImageArr[self.num];
    int i = (int)btn.tag-((self.num+1)*10);
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",arr[i]]];
    CGFloat loat = image.size.width/image.size.height;
    
    self.sizeImage.image = image;
    self.sizeImage.frame = CGRectMake(0, 0, mainW, mainW/loat);
    self.scroll.contentSize= CGSizeMake(0,mainW/loat);
    self.scroll.contentOffset = CGPointMake(0, 0);
}

@end
