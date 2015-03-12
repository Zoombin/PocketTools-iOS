//
//  OilViewController.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "OilViewController.h"
#import "OilCell.h"
#import "OilInfo.h"

@interface OilViewController ()

@end

@implementation OilViewController {
    NSMutableArray *nearByOilList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"附近油价", nil);
    nearByOilList = [NSMutableArray array];
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    [_locationManager requestAlwaysAuthorization];//添加这句
    [_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
    [self loadNearByOilList:@(currLocation.coordinate.longitude) andLat:@(currLocation.coordinate.latitude)];
}

- (void)loadNearByOilList:(NSNumber *)lon andLat:(NSNumber *)lat {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] nearByOilPrice:lon lat:lat withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                NSArray *array = resultInfo.result[@"data"];
                if ([array count] > 0) {
                    [nearByOilList addObjectsFromArray:[OilInfo initWithArray:array]];
                    [_tableView reloadData];
                }
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }

    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        //访问被拒绝
        [self displayHUDTitle:nil message:@"无法获取位置信息,请确认是否打开定位!" duration:DELAY_TIMES];
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [self displayHUDTitle:nil message:@"无法获取位置信息,请确认是否打开定位!" duration:DELAY_TIMES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [nearByOilList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    OilCell *cell = (OilCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"OilCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    OilInfo *info = nearByOilList[indexPath.row];
    cell.nameLabel.text = info.name;
    cell.addressLabel.text = info.address;
    cell.tagLabel.text = [NSString stringWithFormat:@"标签 : %@", info.fwlsmc];
    cell.distanceLabel.text = [NSString stringWithFormat:@"%@米", info.distance];
    if (![info.gastprice isKindOfClass:[NSNull class]]) {
        for (int i = 0; i < [info.gastprice.allKeys count]; i++) {
            NSString *key = info.gastprice.allKeys[i];
            if (i == 0) {
                cell.fpriceTitleLabel.text = key;
                cell.fpriceLabel.text = info.gastprice[key];
            } else if (i == 1) {
                cell.spriceTitleLabel.text = key;
                cell.spriceLabel.text = info.gastprice[key];
            } else if (i == 2) {
                cell.tpriceTitleLabel.text = key;
                cell.tpriceLabel.text = info.gastprice[key];
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
