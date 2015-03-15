//
//  PMViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PMViewController.h"

@interface PMViewController ()

@end

@implementation PMViewController {
    NSMutableArray *locationArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"PM2.5", nil);
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
             [self searchPMByCity:cityName];
             [self searchAirByCity:cityName];
         }
     }];
    [self.locationManager stopUpdatingLocation];
}

- (void)searchPMByCity:(NSString *)cityName {
    [locationArray removeAllObjects];
    [_tableView reloadData];
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchAirByCity:cityName withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *infoArray = (NSArray *)resultInfo.result;
                if ([infoArray count] != 0) {
                    NSDictionary *dict = infoArray[0];
                    NSDictionary *cityNow = dict[@"citynow"];
                    _nowLabel.text = cityNow[@"AQI"];
                    if (dict[@"lastMoniData"]) {
                        [locationArray addObjectsFromArray:[dict[@"lastMoniData"] allValues]];
                        [_tableView reloadData];
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

- (void)searchAirByCity:(NSString *)cityName {
    [[ServiceRequest shared] searchPM25ByCity:cityName WithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *infoArray = (NSArray *)resultInfo.result;
                if ([infoArray count] != 0) {
                    NSDictionary *dict = infoArray[0];
                    _nowPMLabel.text = [NSString stringWithFormat:@"PM2.5 : %@ PM10 : %@ SO2 : %@ NO2 : %@", dict[@"PM2.5"], dict[@"PM10"], dict[@"SO2"], dict[@"NO2"]];
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    NSDictionary *info = locationArray[indexPath.row];
    cell.textLabel.text = info[@"city"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"空气质量: %@", info[@"AQI"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
