//
//  SizesViewController.h
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SizesViewController : PTViewController

@property (nonatomic,strong) UIImageView *backImage;
//服装view
@property (nonatomic,strong) UIView *fuzhuangView;

@property (nonatomic,strong) NSMutableArray *viewArr;
//图片数组
@property (nonatomic,strong) NSArray *ImageArr;
//尺码表图片
@property (nonatomic,strong) UIImageView *sizeImage;
//滚动视图
@property (nonatomic,strong) UIScrollView *scroll;
//保存当前是哪一个view
@property (nonatomic,assign) int num;
//保存chousebBtn
@property (nonatomic,strong) UIButton *oldchouseBtn;
//保存sizeBtn
@property (nonatomic,strong) UIButton *oldsizeBtn;
@end
