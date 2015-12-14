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
#import "WebViewController.h"
#import "ThreeHourInfo.h"
#import "BackgroundViewController.h"
#import "StarCurrentInfo.h"

@interface MainViewController ()

@end

@implementation MainViewController {
    NSArray *allApps;
    NSArray *allStroes;
    NSArray *currentApps;
    NSMutableArray *bottomButtons;
    UIScrollView *menuScrollView;
    UIPageControl *pageControl1;
    UIPageControl *pageControl2;
    NSArray *weatherArray;
    NSString *currentCity;
    NSDictionary *icons;
    UITapGestureRecognizer *weatherGesture;
    UITapGestureRecognizer *pmGesture1;
    UITapGestureRecognizer *pmGesture2;
    UITapGestureRecognizer *pmGesture3;
    UITapGestureRecognizer *starGesture;
    NSArray *stars;
}

- (void)initAllIcons {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Weather" ofType:@"plist"];
    icons = [[NSDictionary alloc] initWithContentsOfFile:path];
}

//显示天气
- (void)showCityWeather {
    Class viewCtrl = NSClassFromString(@"WeatherViewController");
    id ctrl = [viewCtrl new];
    [BackButtonTool addBackButton:ctrl];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)showStar {
    Class viewCtrl = NSClassFromString(@"StarViewController");
    id ctrl = [viewCtrl new];
    [BackButtonTool addBackButton:ctrl];
    [self.navigationController pushViewController:ctrl animated:YES];
}

//显示PM2.5
- (void)showPM {
    Class viewCtrl = NSClassFromString(@"PMViewController");
    id ctrl = [viewCtrl new];
    [BackButtonTool addBackButton:ctrl];
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (void)loadStarInfo {
    NSString *starName = [[ServiceRequest shared] getStarName];
    [_currentStarBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%lu.png", (unsigned long)[stars indexOfObject:starName]]] forState:UIControlStateNormal];
    [_currentStarBtn setTitle:starName forState:UIControlStateNormal];
    [self showLoading];
    [[ServiceRequest shared] searchStarLuckByName:starName type:@"today" withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                StarCurrentInfo *cInfo = [[StarCurrentInfo alloc] initWithAttributes:result];
                [self showInfoWithCurrent:cInfo];
                [self hidenLoading];
            } else {
                [self hidenLoading];
            }
        } else {
            [self hidenLoading];
        }
    }];
}

- (void)showInfoWithCurrent:(StarCurrentInfo *)info {
    NSLog(@"%@", info);
    _currentRateLabel.text = info.all;
    [_healthBtn setTitle:info.health forState:UIControlStateNormal];
    [_loveBtn setTitle:info.love forState:UIControlStateNormal];
    [_moneyBtn setTitle:info.money forState:UIControlStateNormal];
    [_workBtn setTitle:info.work forState:UIControlStateNormal];
    _contentTextView.text = info.summary;
    [_contentTextView setFont:[UIFont fontWithName:@"FZKATJW--GB1-0" size:16]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadStarInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if([[ServiceRequest shared] getBackground]) {
        [self.view setBackgroundColor:[[ServiceRequest shared] getBackground]];
    }
    [self.navigationController.navigationBar setBarTintColor:[[ServiceRequest shared] getBackground]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    stars = @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座", @"水瓶座", @"双鱼座"];
    weatherGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCityWeather)];
    pmGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPM)];
    pmGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPM)];
    pmGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPM)];
    starGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showStar)];
    
    [_weatherView addGestureRecognizer:weatherGesture];
    [_pmtitleLabel addGestureRecognizer:pmGesture1];
    [_pmLabel addGestureRecognizer:pmGesture2];
    [_pmDesLabel addGestureRecognizer:pmGesture3];
    [_starView addGestureRecognizer:starGesture];
    
    [self initAllIcons];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(menuClicked)];
    self.title = @"微工具";
    [self initScrollView];
    
    [_scrollView setPagingEnabled:YES];
    [_scrollView setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width * 2, 0)];
    [_scrollView setFrame:CGRectMake(0, 64, _weatherView.frame.size.width, _weatherView.frame.size.height)];
    [self.view addSubview:_scrollView];
    
    [_weatherView setFrame:CGRectMake(0, 0, _weatherView.frame.size.width, _weatherView.frame.size.height)];
    [_scrollView addSubview:_weatherView];
    
    [_starView setFrame:CGRectMake(0 + [UIScreen mainScreen].bounds.size.width, 0, _starView.frame.size.width, _weatherView.frame.size.height)];
    [_scrollView addSubview:_starView];
    
    pageControl1 = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(menuScrollView.frame) - 15, 320, 20)];
    [pageControl1 setBackgroundColor:[UIColor clearColor]];
    [pageControl1 addTarget:self action:@selector(changePage1:) forControlEvents:UIControlEventValueChanged];
    pageControl1.numberOfPages = 2;
    [self.view addSubview:pageControl1];

    
    bottomButtons = [NSMutableArray array];
    [self addBottomButtons];
    [self bottomButtonClicked:bottomButtons[0]];
    [self initAllApps];
    [self initAllStores];
    [self initMenuButtons:0];
    [self loadLocalData];
    
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        [_locationManager requestAlwaysAuthorization];//添加这句
    }
    [_locationManager startUpdatingLocation];
}

- (void)showLoading {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_loadingView];
}

- (void)hidenLoading {
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    //获取所在地城市名
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for(CLPlacemark *placemark in placemarks)
         {
             NSString *cityName = [[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
             if (cityName) {
                 currentCity = cityName;
                 [self searchCityByName:cityName];
             }
         }
     }];
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"获取位置出错!");
    if (![[ServiceRequest shared] getCityName]) {
        currentCity = @"北京";
        [self searchCityByName:@"北京"];
    }
}

- (void)searchPMByCity:(NSString *)cityName {
    [self showLoading];
    [[ServiceRequest shared] searchPM25ByCity:cityName WithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hidenLoading];
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    if ([array count] > 0) {
                        [[ServiceRequest shared] savePMInfo:array[0]];
                        [self showPMInfo:array[0]];
                    }
                }
            } else {
                [self hidenLoading];
            }
        } else {
            [self hidenLoading];
        }
    }];
}

- (void)showPMInfo:(NSDictionary *)info {
    _pmLabel.text = info[@"AQI"];
    _pmDesLabel.text = info[@"quality"];
    NSInteger aqi = [info[@"AQI"] integerValue];
    if (aqi <= 50) {
        _pmDesLabel.backgroundColor = [UIColor greenColor];
    } else if (aqi > 50 && aqi <= 100) {
        _pmDesLabel.backgroundColor = [UIColor greenColor];
    } else if (aqi > 100 && aqi <= 200) {
        _pmDesLabel.backgroundColor = [UIColor yellowColor];
    } else if (aqi > 200){
        _pmDesLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)showWeatherInfo:(NSDictionary *)info {
    WeatherTodayInfo *tInfo = [[WeatherTodayInfo alloc] initWithAttributes:info[@"today"]];
    WeatherCurrentInfo *cInfo = [[WeatherCurrentInfo alloc] initWithAttributes:info[@"sk"]];
    [self showCurrentInfo:cInfo];
    [self showTodayInfo:tInfo];
}

- (void)loadLocalData {
    currentCity = [[ServiceRequest shared] getCityName];
    if (currentCity != nil) {
        NSDictionary *weatherInfo = [[ServiceRequest shared] getWeather];
        if (weatherInfo) {
            [self showWeatherInfo:weatherInfo];
        }
        NSDictionary *pmInfo = [[ServiceRequest shared] getPMinfo];
        if (pmInfo) {
            [self showPMInfo:pmInfo];
        }
        NSArray *threeHour = [[ServiceRequest shared] getThreeWeather];
        if (threeHour) {
            [self showThreeHourInfo:threeHour];
        }
    }
}

- (void)threeHour:(NSString *)city {
    [self showLoading];
    [[ServiceRequest shared] threeHour:city withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo = [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hidenLoading];
                NSArray *array = (NSArray *)resultInfo.result;
                [[ServiceRequest shared] saveThreeWeather:array];
                [self searchPMByCity:city];
                [self showThreeHourInfo:array];
            } else {
                [self hidenLoading];
            }
        } else {
            [self hidenLoading];
        }
    }];
}

- (void)searchCityByName:(NSString *)name {
    [self showLoading];
    [[ServiceRequest shared] getWeatherByIdOrName:name withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo = [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hidenLoading];
                [[ServiceRequest shared] saveCityName:name];
                [[ServiceRequest shared] saveWeather:resultInfo.result];
                [self showWeatherInfo:resultInfo.result];
                [self threeHour:name];
            } else {
                [self hidenLoading];
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self hidenLoading];
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)showThreeHourInfo:(NSArray *)arr {
    NSArray *resultArray = arr;
    weatherArray = [ThreeHourInfo initWithArray:resultArray];
    CGFloat width = 80;
    CGFloat height = _futureWeatherScrollView.frame.size.height/3;
    for (int i = 0; i < [weatherArray count]; i++) {
        ThreeHourInfo *info = weatherArray[i];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setTextColor:[UIColor whiteColor]];
        [label1 setFont:[UIFont systemFontOfSize:14]];
        [label1 setText:[NSString stringWithFormat:@"%ld点", [info.sh integerValue]]];
        [_futureWeatherScrollView addSubview:label1];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i + ((width - height) / 2), CGRectGetMaxY(label1.frame), height, height)];
        NSString *icon = icons[info.weatherid][@"ic"];
        [iconView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]]];
        [_futureWeatherScrollView addSubview:iconView];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(iconView.frame), width, height)];
        [label3 setTextAlignment:NSTextAlignmentCenter];
        [label3 setTextColor:[UIColor whiteColor]];
        [label3 setFont:[UIFont systemFontOfSize:14]];
        [label3 setText:[NSString stringWithFormat:@"%@°", info.temp2]];
        [_futureWeatherScrollView addSubview:label3];
    }
    [_futureWeatherScrollView setContentSize:CGSizeMake(width * [weatherArray count], 0)];
}

- (void)showTodayInfo:(WeatherTodayInfo *)tInfo {
    NSString *fo = tInfo.weather_id[@"fa"];
    NSString *pic = icons[fo][@"bg"];
    NSString *icon = icons[fo][@"ic"];
    NSArray *tmpArray = [tInfo.temperature componentsSeparatedByString:@"~"];
    if ([tmpArray count] == 2) {
        _lowLabel.text = tmpArray[0];
        _highLabel.text = tmpArray[1];
    }
    [_iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]]];
    _weatherLabel.text = tInfo.weather;
}

- (void)showCurrentInfo:(WeatherCurrentInfo *)cInfo {
    _tmptureLabel.text = [NSString stringWithFormat:@"%@%@", cInfo.temp, @"°"];
    _timeLabel.text = [NSString stringWithFormat:@"%@更新", cInfo.time];
    _cityLabel.text = currentCity;
}

- (void)menuClicked {
    //TODO:菜单
    BackgroundViewController *viewCtrl = [BackgroundViewController new];
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = sender.frame.size.width;
    int page = floor((sender.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"%d", page);
    if (sender == _scrollView) {
        pageControl1.currentPage = page;
    } else {
        pageControl2.currentPage = page;
    }
}

- (void)changePage1:(id)sender
{
    NSInteger page = pageControl1.currentPage;
    [_scrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width * page, 0)];
}

- (void)changePage2:(id)sender
{
    NSInteger page = pageControl2.currentPage;
    // update the scroll view to the appropriate page
    CGRect frame = menuScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [menuScrollView setContentOffset:CGPointMake(frame.size.width * page, -64)];
}

- (void)initScrollView {
    menuScrollView = [[UIScrollView alloc] init];
    [menuScrollView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
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
    CGFloat height = width;
    [menuScrollView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - (height * 2) - buttonHeight - 20, [UIScreen mainScreen].bounds.size.width, height * 2)];
     [self.view addSubview:menuScrollView];
    
    pageControl2 = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menuScrollView.frame), 320, 20)];
    [pageControl2 setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2]];
    [pageControl2 addTarget:self action:@selector(changePage2:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:pageControl2];
}



- (void)addBottomButtons {
    NSArray *buttonNames = @[@"日常工具", @"生活服务", @"充值服务", @"微商城"];
    NSInteger buttonCount = [buttonNames count];
    NSArray *imageNames = @[@"daily", @"life", @"pay", @"99store"];
    NSArray *imageSel = @[@"daily_sel", @"life_sel", @"pay_sel", @"99store_sel"];
    NSInteger buttonWidth = ([UIScreen mainScreen].bounds.size.width) / buttonCount;
    NSInteger buttonHeight = buttonWidth * 0.66;
    for (int i = 0; i <buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [button setFrame:CGRectMake(i * buttonWidth, [UIScreen mainScreen].bounds.size.height - buttonHeight, buttonWidth, buttonHeight)];
        if (i == [buttonNames count] - 1) {
            [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, [UIScreen mainScreen].bounds.size.width - button.frame.origin.x, buttonHeight)];
        }
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

- (void)initAllStores {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"StoreList" ofType:@"plist"];
    NSArray *infoArray = [[NSArray alloc] initWithContentsOfFile:path];
    if ([infoArray count] > 0) {
        allStroes = [AppInfoEntity initWithArray:infoArray];
    }
}

- (void)initAllApps {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AppList" ofType:@"plist"];
    NSArray *infoArray = [[NSArray alloc] initWithContentsOfFile:path];
    if ([infoArray count] > 0) {
        allApps = [AppInfoEntity initWithArray:infoArray];
    }
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
         NSArray *apps = @[@"天气预报", @"空气质量", @"车辆违章", @"加油站", @"停车场", @"快递", @"电影", @"航班动态", @"星座", @"老黄历", @"周公解梦", @"POI"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (index == 2) {
        NSArray *apps = @[@"话费充值", @"游戏充值", @"彩票购买", @"旅游门票", @"火车订票"];
        currentApps = [self getAppsWithAppNames:apps];
        [self setElements:currentApps];
    } else if (index == 3) {
        NSArray *apps = @[@"天天特价", @"大众团购", @"一号店", @"美团外卖", @"饿了吗", @"百度外卖", @"外卖超人", @"聚划算", @"潮流女装", @"精品男装", @"周末去哪玩", @"美团", @"每日爆款", @"抢火车票", @"爱淘宝", @"彩票", @"猫眼", @"微信电影票"];
        currentApps = [self getStoresWithAppNames:apps];
        [self setElements:currentApps];
    }
}

- (NSArray *)getStoresWithAppNames:(NSArray *)names {
    if ([names count] == 0) {
        return nil;
    }
    NSMutableArray *appsArray = [NSMutableArray array];
    for (NSString *appName in names) {
        for (int j = 0; j < allStroes.count; j++) {
            AppInfoEntity *entity = allStroes[j];
            if ([appName isEqualToString:entity.appName]) {
                [appsArray addObject:entity];
            }
        }
    }
    return appsArray;
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
    [pageControl2 setNumberOfPages:page];
    CGRect rect = CGRectZero;
    CGFloat width = [UIScreen mainScreen].bounds.size.width / numberPerLine;
    CGFloat height = width;
    rect.size.width = width;
    rect.size.height = height;
    NSInteger index = 0;
    NSInteger line = 0;
    NSInteger currentPage = 0;
    for (int i = 0; i < count;) {
        AppInfoEntity *entity = elements[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:entity.iconName] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 5, 0)];
        [button.layer setBorderColor:[UIColor whiteColor].CGColor];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor:[UIColor clearColor]];
//        [button.layer setBorderWidth:.5];
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
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.frame.size.height - 10, button.frame.size.width, 10)];
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
    AppInfoEntity *entity = currentApps[[sender tag]];
    if (entity.url != nil) {
        WebViewController *webViewController = [WebViewController new];
        webViewController.url = entity.url;
        webViewController.title = entity.appName;
        [BackButtonTool addBackButton:webViewController];
        [self.navigationController pushViewController:webViewController animated:YES];
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
