//
//  BackgroundViewController.m
//  PocketTools
//
//  Created by yc on 15-3-24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController {
    NSArray *backgrounds;
    NSMutableArray *btns;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    btns = [[NSMutableArray alloc] init];
    
    backgrounds = [ServiceRequest shared].backGrounds;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offSetX = 10.0f;
    CGFloat buttonWidth = (screenWidth - offSetX * 4) / 3;
    CGFloat buttonHeight = buttonWidth;
    
    //总共9种颜色
    NSInteger row = 0;
    NSInteger index = 0;
    for (int i = 0; i < backgrounds.count; i++) {
        if (index % 3 == 0 && i != 0) {
            row++;
            index = 0;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:backgrounds[i]];
        button.frame = CGRectMake(offSetX * (index + 1) + index * buttonWidth, CGRectGetMaxY(_titleLabel.frame) + 15 + offSetX * row + (row * buttonHeight), buttonWidth, buttonHeight);
        button.tag = i;
        [button addTarget:self action:@selector(bkgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        [btns addObject:button];
        index++;
    }
    self.title = @"修改皮肤";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSNumber *indexNumber = [userDefault objectForKey:BACKGROUND];
    [self saveBkg:indexNumber == nil ? 7 : indexNumber.integerValue];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bkgButtonClicked:(id)sender {
    NSInteger tag = [sender tag];
    [self saveBkg:tag];
}

- (void)saveBkg:(NSInteger)index {
    [[ServiceRequest shared] saveBackGround:@(index)];
    [self.view setBackgroundColor:[[ServiceRequest shared] getBackground]];
    
    [self allUnSelected];
    [self selectWithIndex:index];
    [self.navigationController.navigationBar setBarTintColor:[[ServiceRequest shared] getBackground]];
}

- (void)selectWithIndex:(NSInteger)index {
    UIButton *button = btns[index];
    [button.layer setBorderColor:[UIColor whiteColor].CGColor];
    [button.layer setBorderWidth:1];
}

- (void)allUnSelected {
    for (int i = 0; i < btns.count; i++) {
        UIButton *button = btns[i];
        [button.layer setBorderColor:[UIColor clearColor].CGColor];
    }
}
@end
