//
//  ViewController.m
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    BOOL shouldPageToFirst;
    BOOL shouldPageToEnd;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    shouldPageToFirst = NO;
    shouldPageToEnd = NO;
    [_segmentedControl addTarget:self action:@selector(initMenuButtons) forControlEvents:UIControlEventValueChanged];
    [_menuScrollView setScrollEnabled:YES];
    [_menuScrollView setPagingEnabled:YES];
    [self initMenuButtons];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)removeAllButtons {
    for (UIView *v in _menuScrollView.subviews) {
        [v removeFromSuperview];
    }
}

- (void)initMenuButtons {
    [self removeAllButtons];
    int buttonCount = 0;
    if (_segmentedControl.selectedSegmentIndex == 0) {
        buttonCount = 12;
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        buttonCount = 15;
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        buttonCount = 21;
    }
    float screenWidth = _menuScrollView.frame.size.width;
    float buttonWidth = screenWidth / 5;
    float buttonHeight = _menuScrollView.frame.size.height / 2;
    int line = 1;
    int page = 1;
    if (buttonCount > 10) {
        if (buttonCount % 10 == 0) {
            page = buttonCount / 10;
        } else {
            page = buttonCount / 10 + 1;
        }
    }
    [_menuScrollView setContentSize:CGSizeMake((screenWidth) * page, buttonHeight * 2)];
    [_menuScrollView setContentOffset:CGPointMake(0, 0)];
    [_menuPageControl setNumberOfPages:page];
    _menuPageControl.currentPage = 0;					
    int index = 0;
    int currentPage = 1;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(buttonWidth * index + (currentPage - 1) * buttonWidth * 5, (line - 1) * buttonHeight, buttonWidth, buttonHeight)];
        [button setTitle:@"按钮" forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:i % 2 == 0 ? [UIColor blueColor] : [UIColor redColor]];
        [_menuScrollView addSubview:button];
        
        if ((i + 1) % 10 == 0) {
            currentPage ++;
            index = 0;
            line = 1;
        }else if ((i + 1) % 5 == 0 && (i + 1) % 10 != 0) {
            index = 0;
            line = 2;
        } else {
            index ++;
        }
    }
}

- (void)menuButtonClicked:(id)sender {
    NSLog(@"%ld", [sender tag]);
}

- (IBAction)actionCotrolPage:(id)sender {
    [_menuScrollView setContentOffset:CGPointMake(_menuPageControl.currentPage * _menuScrollView.frame.size.width, 0) animated:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%f", _menuScrollView.contentOffset.x);
    if(_menuScrollView.contentOffset.x > (_menuPageControl.numberOfPages - 1) * _menuScrollView.frame.size.width) {
        NSLog(@"下一页");
        if (_segmentedControl.selectedSegmentIndex == 2) {
            NSLog(@"已经到最后一页了");
            return;
        }
        _segmentedControl.selectedSegmentIndex ++;
        shouldPageToFirst = YES;
    } else if (_menuScrollView.contentOffset.x < 0) {
        NSLog(@"上一页");
        if (_segmentedControl.selectedSegmentIndex == 0) {
            NSLog(@"已经到第一页了");
            return;
        }
        _segmentedControl.selectedSegmentIndex --;
        if (_segmentedControl.selectedSegmentIndex < 0) {
            _segmentedControl.selectedSegmentIndex = 0;
        }
        shouldPageToEnd = YES;
    }
}

// UIScrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (shouldPageToFirst) {
        shouldPageToFirst = NO;
        [self initMenuButtons];
        [_menuScrollView setContentOffset:CGPointMake(0, 0)];
        return;
    } else if (shouldPageToEnd) {
        shouldPageToEnd = NO;
        [self initMenuButtons];
        [_menuScrollView setContentOffset:CGPointMake(_menuScrollView.frame.size.width * (_menuPageControl.numberOfPages - 1), 0)];
        _menuPageControl.currentPage = _menuPageControl.numberOfPages - 1;
        return;
    }
    _menuPageControl.currentPage = _menuScrollView.contentOffset.x / _menuScrollView.frame.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
