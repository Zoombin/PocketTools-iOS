//
//  ViewController.m
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MainViewController.h"
#import "AppInfoEntity.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    NSArray *allApps;
    NSArray *currentApps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_segmentedControl addTarget:self action:@selector(initMenuButtons) forControlEvents:UIControlEventValueChanged];
    [_menuScrollView setScrollEnabled:YES];
    [_menuScrollView setPagingEnabled:YES];
    
    [self initAllApps];
    [self initMenuButtons];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initAllApps {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppList" ofType:@"plist"];
    NSArray *infoArray = [[NSArray alloc] initWithContentsOfFile:path];
    if ([infoArray count] > 0) {
        allApps = [AppInfoEntity initWithArray:infoArray];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)removeAllButtons {
    for (UIView *v in _menuScrollView.subviews) {
        [v removeFromSuperview];
    }
}

- (void)initMenuButtons {
    [self removeAllButtons];
    if (_segmentedControl.selectedSegmentIndex == 0) {
        NSArray *apps = @[@"苹果序列号", @"老黄历" ,@"天气预报", @"镜子", @"秘密相册", @"话费充值", @"空气质量", @"周公解梦", @"科学计算器", @"汇率换算", @"大写换算", @"手电筒", @"尺码对照表", @"条码比价"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        NSArray *apps = @[@"车辆违章", @"快递", @"火车订票", @"来电号码查询", @"电影", @"航班动态", @"彩票购买", @"加油站"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        NSArray *apps = @[@"新闻", @"星座", @"POI", @"游戏充值", @"流量直充", @"停车场", @"聊天机器人", @"尺子"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    }
}

- (NSArray *)getAppsWithAppNames:(NSArray *)names {
    NSMutableArray *appsArray = [NSMutableArray array];
    for (NSString *appName in names) {
        for (int j = 0; j < allApps.count; j++) {
            AppInfoEntity *entity = allApps[j];
            if ([appName isEqualToString:entity.appName]) {
                [appsArray addObject:entity];
            }
        }
    }
    return appsArray;
}

static NSInteger const numberPerLine = 4;
- (void)setElements:(NSArray *)elements {
    NSInteger numberOfLine = 1;
    NSInteger count = [elements count];
    if (count > 4) {
        if ([elements count] % 4 == 0) {
            numberOfLine = count / 4;
        } else {
            numberOfLine = count / 4 + 1;
        }
    } else {
        numberOfLine = 1;
    }
    
    CGRect rect = CGRectZero;
    CGFloat width = _menuScrollView.bounds.size.width / 4;
    CGFloat height = width;
    rect.size.width = width;
    rect.size.height = height;
    for (int i = 0; i < count;) {
        AppInfoEntity *entity = elements[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:entity.iconName] forState:UIControlStateNormal];
        [button.layer setBorderColor:[UIColor whiteColor].CGColor];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor colorWithRed:35/255.0 green:57/255.0 blue:70/255.0 alpha:1.0]];
        [button.layer setBorderWidth:.5];
        [button setTag:i];
        button.frame = rect;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 25, button.frame.size.width, 15)];
        label.text = entity.appName;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        
        [_menuScrollView addSubview:button];
        i++;
        if (i % (numberPerLine * numberOfLine) == 0) {
            rect.origin.x = _menuScrollView.bounds.size.width * (count / numberPerLine);
            rect.origin.y = 0;
        } else if (i % numberPerLine == 0) {
            rect.origin.x = 0;
            rect.origin.y = height * (i / 4);
        } else {
            rect.origin.x += width;
        }
    }
    _menuScrollView.contentSize = CGSizeMake(_menuScrollView.bounds.size.width, height * (numberOfLine - 1));
}

- (void)menuButtonClicked:(id)sender {
    NSLog(@"%ld", [sender tag]);
    AppInfoEntity *entity = currentApps[[sender tag]];
    if ([entity.controlName isEqualToString:@""]) {
        return;
    }
    id viewCtrl = [NSClassFromString(entity.controlName) new];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
