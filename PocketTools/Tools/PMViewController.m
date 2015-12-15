//
//  PMViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PMViewController.h"
#import "PMCell.h"

@interface PMViewController ()

@end

@implementation PMViewController {
    NSMutableArray *locationArray;
    NSMutableArray *data;
    EColumnChart *_eColumnChart;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"PM2.5", nil);
    data = [NSMutableArray array];
    locationArray = [NSMutableArray array];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(getCityList)];
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        [_locationManager requestAlwaysAuthorization];//添加这句
    }
    [_locationManager startUpdatingLocation];
    [_tableView setTableHeaderView:_headerView];
}

- (void)initPmView {    
    _eColumnChart = [[EColumnChart alloc] initWithFrame:CGRectMake(40, 0, _pmView.frame.size.width - 80, _pmView.frame.size.height)];
    [_eColumnChart setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [_eColumnChart setColumnsIndexStartFromLeft:YES];
    [_eColumnChart setDelegate:self];
    [_eColumnChart setDataSource:self];
    [_pmView addSubview:_eColumnChart];
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
             if (cityName) {
                 [self searchPMByCity:cityName];
                 [self searchAirByCity:cityName];
             }
         }
     }];
    [self.locationManager stopUpdatingLocation];
}

- (void)searchPMByCity:(NSString *)cityName {
    [locationArray removeAllObjects];
    [_tableView reloadData];
    [data removeAllObjects];
    for (UIView *v in _pmView.subviews) {
        [v removeFromSuperview];
    }
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchAirByCity:cityName withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *infoArray = (NSArray *)resultInfo.result;
                if ([infoArray count] != 0) {
                    NSDictionary *dict = infoArray[0];
                    if (dict[@"lastMoniData"]) {
                        [locationArray addObjectsFromArray:[dict[@"lastMoniData"] allValues]];
                        [_tableView reloadData];
                    }
                    if (dict[@"lastTwoWeeks"]) {
                        if ([[dict[@"lastTwoWeeks"] allKeys] count]> 0) {
                            [self loadPMdata:dict[@"lastTwoWeeks"]];
                        }
                    }
                }
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)loadPMdata:(NSDictionary *)lastTwoWeeks {
    NSArray *charArray = [lastTwoWeeks allKeys];
    NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch|NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSComparator sort = ^(NSString *obj1, NSString *obj2){
        NSRange range = NSMakeRange(0, obj1.length);
        return [obj1 compare:obj2 options:comparisonOptions range:range];
    };
    NSArray *resultArray2 = [charArray sortedArrayUsingComparator:sort];
    NSLog(@"字符串数组排序结果%@",resultArray2);
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"MM-dd"];
    NSInteger count = [resultArray2 count];
    for (int i = 1; i < 8 ; i++) {
        NSString *key = resultArray2[count - i];
        NSDictionary *dict = lastTwoWeeks[key];
        NSLog(@"%@", dict);
        NSDate *date = [dateFormatter1 dateFromString:dict[@"date"]];
        NSString *dateString = [dateFormatter2 stringFromDate:date];
        EColumnDataModel *eColumnDataModel = [[EColumnDataModel alloc] initWithLabel:dateString value:[dict[@"AQI"] floatValue] index:i unit:@""];
        [data addObject:eColumnDataModel];
    }
    [self initPmView];
}

- (void)searchAirByCity:(NSString *)cityName {
    [[ServiceRequest shared] searchPM25ByCity:cityName WithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *infoArray = (NSArray *)resultInfo.result;
                if ([infoArray count] != 0) {
                    NSDictionary *dict = infoArray[0];
                    _nowLabel.text = dict[@"AQI"];
                    _nowDesLabel.text = dict[@"quality"];
                    _nowDesLabel.backgroundColor = [self setColorWithPM:[dict[@"AQI"] integerValue]];
                    _pm25ValueLabel.text = dict[@"PM2.5"];
                    _pmValueLabel.text = dict[@"PM10"];
                    _so2ValueLabel.text = dict[@"SO2"];
                    _no2ValueLabel.text = dict[@"NO2"];
                }
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)getCityList {
    PMCitySelectViewController *viewCtrl = [PMCitySelectViewController new];
    viewCtrl.delegate = self;
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)selectCityName:(NSString *)cityName {
    self.title = cityName;
    [self searchPMByCity:cityName];
    [self searchAirByCity:cityName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [locationArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    PMCell *cell = (PMCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PMCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *info = locationArray[indexPath.row];
    cell.locationLabel.text = info[@"city"];
    cell.pmDescribeLabel.text = info[@"quality"];
    cell.pmDescribeLabel.textColor = [self setColorWithPM:[info[@"AQI"] integerValue]];
    cell.pmLabel.textColor = [self setColorWithPM:[info[@"AQI"] integerValue]];
    cell.pmLabel.text = info[@"AQI"];
    return cell;
}

- (UIColor *)setColorWithPM:(NSInteger)pm {
    if (pm <= 50) {
        return [UIColor greenColor];
    } else if (pm > 50 && pm <= 100) {
        return [UIColor greenColor];
    } else if (pm > 100 && pm <= 200) {
        return [UIColor yellowColor];
    } else if (pm > 200) {
        return [UIColor redColor];
    }
    return [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark ChartView
#pragma -mark- Actions
- (IBAction)highlightMaxAndMinChanged:(id)sender
{
    UISwitch *mySwith = (UISwitch *)sender;
    if ([mySwith isOn]) {
        [_eColumnChart setShowHighAndLowColumnWithColor:YES];
    } else {
        [_eColumnChart setShowHighAndLowColumnWithColor:NO];
    }
}

- (IBAction)eventHandleChanged:(id)sender
{
    UISwitch *mySwith = (UISwitch *)sender;
    if ([mySwith isOn]) {
        [_eColumnChart setDelegate:self];
    }
    else {
        [_eColumnChart setDelegate:nil];
    }
}

- (IBAction)chartDirectionChanged:(id)sender
{
    UISwitch *mySwith = (UISwitch *)sender;
    if ([mySwith isOn]) {
        [_eColumnChart removeFromSuperview];
        _eColumnChart = nil;
        _eColumnChart = [[EColumnChart alloc] initWithFrame:CGRectMake(40, 100, 250, 200)];
        [_eColumnChart setColumnsIndexStartFromLeft:YES];
        [_eColumnChart setDelegate:self];
        [_eColumnChart setDataSource:self];
        [self.view addSubview:_eColumnChart];
    } else {
        [_eColumnChart removeFromSuperview];
        _eColumnChart = nil;
        _eColumnChart = [[EColumnChart alloc] initWithFrame:CGRectMake(40, 100, 250, 200)];
        [_eColumnChart setColumnsIndexStartFromLeft:NO];
        [_eColumnChart setDelegate:self];
        [_eColumnChart setDataSource:self];
        [self.view addSubview:_eColumnChart];
    }
}

#pragma -mark- EColumnChartDataSource

- (NSInteger)numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart
{
    return [data count];
}

- (NSInteger)numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart
{
    return 7;
}

- (EColumnDataModel *)highestValueEColumnChart:(EColumnChart *)eColumnChart
{
    EColumnDataModel *maxDataModel = nil;
    float maxValue = -FLT_MIN;
    for (EColumnDataModel *dataModel in data)
    {
        if (dataModel.value > maxValue)
        {
            maxValue = dataModel.value;
            maxDataModel = dataModel;
        }
    }
    return maxDataModel;
}

- (EColumnDataModel *)eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index
{
    if (index >= [data count] || index < 0) return nil;
    return [data objectAtIndex:index];
}

#pragma -mark- EColumnChartDelegate
- (void)eColumnChart:(EColumnChart *)eColumnChart
     didSelectColumn:(EColumn *)eColumn {
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidEnterColumn:(EColumn *)eColumn {
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidLeaveColumn:(EColumn *)eColumn {
    
}

- (void)fingerDidLeaveEColumnChart:(EColumnChart *)eColumnChart {
    
}

@end
