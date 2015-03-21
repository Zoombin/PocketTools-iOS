//
//  DailyViewController.m
//  PocketTools
//
//  Created by yc on 15-3-18.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "DailyViewController.h"
#import "AppInfoEntity.h"

@interface DailyViewController ()

@end

@implementation DailyViewController {
    NSArray *allApps;
    NSArray *currentApps;
    NSMutableArray *bottomButtons;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *normalImage = [UIImage imageNamed:@"daily"];
        UIImage *selectedImage = [UIImage imageNamed:@"daily_sel"];
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
    [self initMenuButtons:1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)bottomButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    [button setImageEdgeInsets:UIEdgeInsetsMake(25, 0, 0, 0)];
    button.selected = YES;
    
    UILabel *label = (UILabel *)[button viewWithTag:[sender tag] + 1000];
    [label setTextColor:[UIColor whiteColor]];
    [self initMenuButtons:[sender tag]];
    
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
     NSArray *apps = @[@"科学计算器", @"秘密相册", @"镜子", @"手电筒", @"尺子", @"尺码对照表", @"汇率换算", @"单位换算", @"苹果序列号", @"聊天机器人", @"来电查询", @"条码比价"];
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
    _menuScrollView.contentSize = CGSizeMake(_menuScrollView.bounds.size.width, height * (numberOfLine - 1));
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
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
