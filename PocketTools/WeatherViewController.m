//
//  WeatherViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherCurrentInfo.h"
#import "WeatherFutureInfo.h"
#import "WeatherTodayInfo.h"
#import "ThreeHourInfo.h"
#import "WeatherCell.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController {
    NSArray *backgroundImages;
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
    backgroundImages = @[@"bg_sunny", @"bg_cloudy", @"bg_normal", @"bg_rain", @""];
    self.title = NSLocalizedString(@"天气预报", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(getCityList)];
    
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        [_locationManager requestAlwaysAuthorization];//添加这句
    }
    [_locationManager startUpdatingLocation];
//    [self searchCityByName:@"苏州"];
    [self addView];
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    //获取所在地城市名
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks,NSError *error)
     {
         for(CLPlacemark *placemark in placemarks)
         {
             NSString *cityName = [[placemark.addressDictionary objectForKey:@"City"] substringToIndex:2];
             self.title = cityName;
             [self searchCityByName:cityName];
         }
     }];
    [self.locationManager stopUpdatingLocation];
}

- (void)addView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    [_firstView setFrame:CGRectMake(0, 0, screenWidth, 200)];
    [_secondView setFrame:CGRectMake(0, 200, screenWidth, 200)];
    [_thirdView setFrame:CGRectMake(0, 400, screenWidth, 170)];
    [_fourView setFrame:CGRectMake(0, 570, screenWidth, 390)];
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_secondView];
    [_scrollView addSubview:_thirdView];
    [_scrollView addSubview:_fourView];
    [_scrollView setContentSize:CGSizeMake(screenWidth, CGRectGetMaxY(_fourView.frame))];
}

- (void)getCityList {
    WeatherCitiesViewController *viewCtrl = [WeatherCitiesViewController new];
    viewCtrl.delegate = self;
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
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
                [_tableView reloadData];
                [self showCurrentInfo:cInfo];
                [self showTodayInfo:tInfo];
                [self threeHour:name];
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)threeHour:(NSString *)city {
    [[ServiceRequest shared] threeHour:city withBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
        if (!error) {
            ServiceResult *resultInfo = [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                NSLog(@"%@", resultInfo.result);
                NSArray *resultArray = (NSArray *)resultInfo.result;
                NSArray *array = [ThreeHourInfo initWithArray:resultArray];
                NSLog(@"%@", array);
                [self showThreeHourInfo:array];
            }
        }
    }];
}

- (void)showThreeHourInfo:(NSArray *)array {
    CGFloat width = 80;
    CGFloat height = _weatherScrollView.frame.size.height/3;
    for (int i = 0; i < [array count]; i++) {
        NSLog(@"%d", i);
        ThreeHourInfo *info = array[i];
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(width * i, 0, width, height)];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setTextColor:[UIColor whiteColor]];
        [label1 setFont:[UIFont systemFontOfSize:14]];
        [label1 setText:[NSString stringWithFormat:@"%ld点", [info.sh integerValue]]];
        [_weatherScrollView addSubview:label1];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(label1.frame) + 20, CGRectGetMaxY(label1.frame), width / 2, height)];
        NSString *icon = icons[info.weatherid][@"ic"];
        [iconView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]]];
        [_weatherScrollView addSubview:iconView];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(label1.frame), CGRectGetMaxY(iconView.frame), width, height)];
        [label3 setTextAlignment:NSTextAlignmentCenter];
        [label3 setTextColor:[UIColor whiteColor]];
        [label3 setFont:[UIFont systemFontOfSize:14]];
        [label3 setText:[NSString stringWithFormat:@"%@°", info.temp2]];
        [_weatherScrollView addSubview:label3];
    }
    [_weatherScrollView setContentSize:CGSizeMake(width * [array count], 0)];
}


- (void)showCurrentInfo:(WeatherCurrentInfo *)cInfo {
    _temLabel.text = [NSString stringWithFormat:@"%@°", cInfo.temp];
    _windLabel.text = cInfo.wind_strength;
    _windLocationLabel.text = cInfo.wind_direction;
    _wetLabel.text = cInfo.humidity;
}

- (void)showTodayInfo:(WeatherTodayInfo *)tInfo {
    NSString *fo = tInfo.weather_id[@"fa"];
    NSString *pic = icons[fo][@"bg"];
    NSString *icon = icons[fo][@"ic"];
    NSArray *lowAndHigh = [tInfo.temperature componentsSeparatedByString:@"~"];
    if ([lowAndHigh count] == 2) {
        _lowLabel.text = lowAndHigh[0];
        _highLabel.text = lowAndHigh[1];
    }
    [_backgroundImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", pic]]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", pic]]]];
    [_iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]]];
    _weatherLabel.text = tInfo.weather;
    _thirdContentTextView.text = tInfo.dressing_advice;
    _thirdContentTextView.numberOfLines = 0;
    _thirdContentTextView.lineBreakMode = NSLineBreakByWordWrapping;
    [_thirdContentTextView sizeToFit];
    _fLabel.text = tInfo.uv_index;
    _sLabel.text = tInfo.travel_index;
    _tLabel.text = tInfo.wash_index;
    _ffLabel.text = tInfo.exercise_index;
    NSLog(@"%@", pic);
}

- (void)selectCityName:(NSString *)cityName {
    self.title = cityName;
    [self searchCityByName:cityName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [weatherArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    WeatherCell *cell = (WeatherCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"WeatherCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    WeatherFutureInfo *info = weatherArray[indexPath.row];
    cell.dayLabel.text = info.week;
    cell.tempLabel.text = info.temperature;
    [cell.weatherLabel setText:info.weather];
    NSString *fo = info.weather_id[@"fa"];
    NSString *icon = icons[fo][@"ic"];
    [cell.weatherButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", icon]] forState:UIControlStateNormal];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
