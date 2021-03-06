//
//  ReadingViewController.m
//  PocketTools
//
//  Created by yc on 15-3-18.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ReadingViewController.h"
#import "AppInfoEntity.h"

@interface ReadingViewController ()

@end

@implementation ReadingViewController {
    NSArray *allApps;
    NSArray *currentApps;
    NSMutableArray *bottomButtons;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *normalImage = [UIImage imageNamed:@"pay"];
        UIImage *selectedImage = [UIImage imageNamed:@"pay_sel"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
       
        self.title = @"99工具";
        self.tabBarItem.title = @"";
//        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
//        self.navigationItem.titleView = titleImageView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    bottomButtons = [NSMutableArray array];
    
    [_menuScrollView setScrollEnabled:YES];
    [_menuScrollView setPagingEnabled:YES];
    
    [self initAllApps];
    [self initMenuButtons:0];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initAllApps {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppList" ofType:@"plist"];
    NSArray *infoArray = [[NSArray alloc] initWithContentsOfFile:path];
    if ([infoArray count] > 0) {
        allApps = [AppInfoEntity initWithArray:infoArray];
    }
}

- (void)removeAllButtons {
    for (UIView *v in _menuScrollView.subviews) {
        [v removeFromSuperview];
    }
}

- (void)initMenuButtons:(NSInteger)index {
    [self removeAllButtons];
    NSArray *apps = @[@"话费充值", @"游戏充值", @"彩票购买", @"旅游门票", @"火车订票"];
    currentApps = [self getAppsWithAppNames:apps];
    [self setElements:currentApps];
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

//static NSInteger const numberPerLine = 4;
- (void)setElements:(NSArray *)elements {
    NSInteger numberPerLine = 4;
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        NSLog(@"6 or 6+");
        numberPerLine = 5;
    }
    NSInteger numberOfLine = 1;
    NSInteger count = [elements count];
    if (count > numberPerLine) {
        if ([elements count] % numberPerLine == 0) {
            numberOfLine = count / numberPerLine;
        } else {
            numberOfLine = count / numberPerLine + 1;
        }
    } else {
        numberOfLine = 1;
    }
    NSInteger page = 1;
    if (numberPerLine > 2) {
        
    } else {
        page = 1;
    }
    
    CGRect rect = CGRectZero;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / numberPerLine;
    CGFloat height = width;
    rect.size.width = width;
    rect.size.height = height;
    for (int i = 0; i < count;) {
        AppInfoEntity *entity = elements[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:entity.iconName] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        button.frame = rect;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 10, button.frame.size.width, 15)];
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
            rect.origin.y = height * (i / numberPerLine);
        } else {
            rect.origin.x += width;
        }
    }
    _menuScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,  height * 2);
}

- (void)menuButtonClicked:(id)sender {
    NSLog(@"%ld", [sender tag]);
    AppInfoEntity *entity = currentApps[[sender tag]];
    if ([entity.controlName isEqualToString:@""]) {
        return;
    }
    UIViewController *viewCtrl = [NSClassFromString(entity.controlName) new];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
