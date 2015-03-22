//
//  ViewController.m
//  PocketTools
//
//  Created by yc on 15-2-25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MainViewController.h"
#import "AppInfoEntity.h"
#import "WeatherCurrentInfo.h"
#import "WeatherFutureInfo.h"
#import "WeatherTodayInfo.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    NSArray *allApps;
    NSArray *currentApps;
    NSMutableArray *bottomButtons;
    UIScrollView *menuScrollView;
    UIPageControl *pageControl;
    NSArray *weatherArray;
    NSDictionary *icons;
}

- (void)initAllIcons {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"plist"];
    icons = [[NSDictionary alloc] initWithContentsOfFile:path];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAllIcons];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(menuClicked)];
    self.title = @"工具99";
    [self initScrollView];
    [_weatherView setFrame:CGRectMake(0, 64, _weatherView.frame.size.width, _weatherView.frame.size.height)];
    [self.view addSubview:_weatherView];
    
    bottomButtons = [NSMutableArray array];
    
    [self addBottomButtons];
    [self bottomButtonClicked:bottomButtons[0]];
    
    [self initAllApps];
    [self initMenuButtons:0];
    [self searchCityByName:@"苏州"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)searchCityByName:(NSString *)name {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] getWeatherByIdOrName:name withBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
        if (!error) {
            ServiceResult *resultInfo = [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                WeatherTodayInfo *tInfo = [[WeatherTodayInfo alloc] initWithAttributes:resultInfo.result[@"today"]];
                WeatherCurrentInfo *cInfo = [[WeatherCurrentInfo alloc] initWithAttributes:resultInfo.result[@"sk"]];
                weatherArray = [WeatherFutureInfo initWithArray:[resultInfo.result[@"future"] allValues]];
//                [_tableView reloadData];
                [self showCurrentInfo:cInfo];
                [self showTodayInfo:tInfo];
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)showTodayInfo:(WeatherTodayInfo *)tInfo {
    NSString *fo = tInfo.weather_id[@"fa"];
    NSString *pic = icons[fo][@"bg"];
    NSString *icon = icons[fo][@"ic"];
    _rangeLabel.text = tInfo.temperature;
    [_iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]]];
    _weatherLabel.text = tInfo.weather;
    NSLog(@"%@", pic);
}

- (void)showCurrentInfo:(WeatherCurrentInfo *)cInfo {
    _tmptureLabel.text = [NSString stringWithFormat:@"%@%@", cInfo.temp, @"°"];
    _timeLabel.text = [NSString stringWithFormat:@"%@更新", cInfo.time];
    _cityLabel.text = @"苏州";
}

- (void)menuClicked {
    //TODO:菜单
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (void)changePage:(id)sender
{
    NSInteger page = pageControl.currentPage;
    // update the scroll view to the appropriate page
    CGRect frame = menuScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [menuScrollView setContentOffset:CGPointMake(frame.size.width * page, -64)];
}

- (void)initScrollView {
    menuScrollView = [[UIScrollView alloc] init];
    [menuScrollView setBackgroundColor:[UIColor colorWithRed:35/255.0 green:57/255.0 blue:70/255.0 alpha:1.0]];
    [menuScrollView setDelegate:self];
    [menuScrollView setScrollEnabled:YES];
    [menuScrollView setPagingEnabled:YES];
    
    
    CGFloat buttonWidth = ([UIScreen mainScreen].bounds.size.width) / 4;
    CGFloat buttonHeight = buttonWidth * 0.66;
    
    NSInteger numberPerLine = 4;
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        numberPerLine = 5;
    }
    CGFloat width = [UIScreen mainScreen].bounds.size.width / numberPerLine;
    CGFloat height = width + 20;
    [menuScrollView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - (height * 2) - buttonHeight - 20, [UIScreen mainScreen].bounds.size.width, height * 2)];
     [self.view addSubview:menuScrollView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menuScrollView.frame), 320, 20)];
    [pageControl setBackgroundColor:[UIColor colorWithRed:35/255.0 green:57/255.0 blue:70/255.0 alpha:1.0]];
    [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl];
}



- (void)addBottomButtons {
    NSArray *buttonNames = @[@"日常工具", @"生活服务", @"充值服务", @"99商城"];
    NSInteger buttonCount = [buttonNames count];
    NSArray *imageNames = @[@"daily", @"life", @"pay", @"99store"];
    NSArray *imageSel = @[@"daily_sel", @"life_sel", @"pay_sel", @"99store_sel"];
    CGFloat buttonWidth = ([UIScreen mainScreen].bounds.size.width) / buttonCount;
    CGFloat buttonHeight = buttonWidth * 0.66;
    for (int i = 0; i <buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [button setFrame:CGRectMake(i * (buttonWidth + 1), [UIScreen mainScreen].bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setBackgroundImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:imageSel[i]] forState:UIControlStateSelected];
        [self.view addSubview:button];
        [bottomButtons addObject:button];
    }
}

- (void)bottomButtonClicked:(id)sender {
    [self allUnSelect];
    UIButton *button = (UIButton *)sender;
    button.selected = YES;
    [self initMenuButtons:[sender tag]];
    
    //TODO:不知道为什么初始点是64，好奇怪..
    [menuScrollView setContentOffset:CGPointMake(0, -64)];
}

- (void)allUnSelect {
    for (UIButton *button in bottomButtons) {
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        button.selected = NO;
        UILabel *label = (UILabel *)[button viewWithTag:[button tag] + 1000];
        [label setTextColor:[UIColor blackColor]];
    }
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
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)removeAllButtons {
    for (UIView *v in menuScrollView.subviews) {
        [v removeFromSuperview];
    }
}

- (void)initMenuButtons:(NSInteger)index {
    [self removeAllButtons];
    if (index == 0) {
       NSArray *apps = @[@"科学计算器", @"秘密相册", @"镜子", @"手电筒", @"尺子", @"尺码对照表", @"汇率换算", @"单位换算", @"苹果序列号", @"聊天机器人", @"来电查询", @"条码比价"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (index == 1) {
         NSArray *apps = @[@"天气预报", @"空气质量", @"车辆违章", @"加油站", @"停车场", @"快递", @"电影", @"航班动态", @"星座", @"老黄历", @"周公解梦", @"POI", @"新闻"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (index == 2) {
        NSArray *apps = @[@"话费充值", @"游戏充值", @"彩票购买", @"旅游门票", @"火车订票"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (index == 3) {
        NSArray *apps = @[];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    }
}

- (NSArray *)getAppsWithAppNames:(NSArray *)names {
    if ([names count] == 0) {
        return nil;
    }
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
    if ([elements count] == 0) {
        return;
    }
    NSInteger numberPerLine = 4;
    if ([UIScreen mainScreen].bounds.size.width > 320) {
        numberPerLine = 5;
    }
    NSInteger numberOfLine = 1;
    NSInteger count = [elements count];
    if (count > numberPerLine) {
        if (count % numberPerLine == 0) {
            numberOfLine = count / numberPerLine;
        } else {
            numberOfLine = count / numberPerLine + 1;
        }
    } else {
        numberOfLine = 1;
    }
    NSInteger page = 1;
    if (numberOfLine  > 2) {
        if (count % (numberPerLine * 2) == 0) {
            page = count / (numberPerLine * 2);
        } else {
            page = (count / (numberPerLine * 2)) + 1;
        }
    }
    [pageControl setNumberOfPages:page];
    CGRect rect = CGRectZero;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / numberPerLine;
    CGFloat height = width + 20;
    rect.size.width = width;
    rect.size.height = height;
    NSInteger index = 0;
    NSInteger line = 0;
    NSInteger currentPage = 0;
    for (int i = 0; i < count;) {
        AppInfoEntity *entity = elements[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:entity.iconName] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 15, 0)];
        [button.layer setBorderColor:[UIColor whiteColor].CGColor];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor colorWithRed:35/255.0 green:57/255.0 blue:70/255.0 alpha:1.0]];
        [button.layer setBorderWidth:.5];
        [button setTag:i];
        if (i % numberPerLine == 0 && i != 0) {
            rect.origin.x = index * width;
            index = 0;
            line++;
            if (i % (numberPerLine * 2) == 0 & i != 0) {
                index = 0;
                line = 0;
                currentPage++;
            }
        } else {
            if (i != 0) {
                index++;
            }
        }
        button.frame = CGRectMake(index * width + currentPage * numberPerLine * width, -64 + (height * line), width, height);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 25, button.frame.size.width, 15)];
        label.text = entity.appName;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        
        [menuScrollView addSubview:button];
        i++;
    }
    menuScrollView.contentSize = CGSizeMake(menuScrollView.frame.size.width * page, 0);
}

- (void)menuButtonClicked:(id)sender {
    NSLog(@"%ld", [sender tag]);
    AppInfoEntity *entity = currentApps[[sender tag]];
    if ([entity.controlName isEqualToString:@""]) {
        return;
    }
    UIViewController *viewCtrl = [NSClassFromString(entity.controlName) new];
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
