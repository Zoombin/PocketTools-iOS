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
#import "MJRefresh.h"

@interface OilViewController ()

@end

@implementation OilViewController {
    NSMutableArray *nearByOilList;
    NSInteger currentPage;
    CLLocation *currLocation;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"附近油价", nil);
    currentPage = 1;
    [self addHeader];
    [self addFooter];
    nearByOilList = [NSMutableArray array];
    self.locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)) {
        [_locationManager requestAlwaysAuthorization];//添加这句
    }
    [_locationManager startUpdatingLocation];
    // Do any additional setup after loading the view from its nib.
}

- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _tableView;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        currentPage = 1;
        [self loadNearByOilList];
    };
    _header = header;
}

- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = _tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        NSLog(@"%@----开始进入刷新状态", refreshView.class);
        currentPage++;
        [self loadNearByOilList];
    };
    _footer = footer;
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currLocation = [locations lastObject];
    [self loadNearByOilList];
}

- (void)loadNearByOilList {
    if (currLocation == nil) {
        return;
    }
    NSNumber *lon = @(currLocation.coordinate.longitude);
    NSNumber *lat = @(currLocation.coordinate.latitude);
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] nearByOilPrice:lon
                                        lat:lat
                                       page:currentPage
                                  withBlock:^(NSDictionary *result, NSError *error) {
                                      [_header endRefreshing];
                                      [_footer endRefreshing];
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
                [self displayHUDTitle:nil message:@"已无更多数据!" duration:DELAY_TIMES];
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
    [cell.addressLabel sizeToFit];
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
