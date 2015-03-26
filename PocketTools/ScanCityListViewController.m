//
//  ScanCityListViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/25.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ScanCityListViewController.h"
#import "ScanCityInfo.h"
#import "ScanProviceInfo.h"

@interface ScanCityListViewController ()

@end

@implementation ScanCityListViewController {
    NSArray *allProvinces;
    NSArray *allCitys;
    NSMutableArray *citysArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"城市选择";
    citysArray = [[NSMutableArray alloc] init];
    CGFloat width = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    [_leftTableView setDelegate:self];
    [_leftTableView setDataSource:self];
    [_leftTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_leftTableView];
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(width, 64, width, height-64) style:UITableViewStylePlain];
    [_rightTableView setDelegate:self];
    [_rightTableView setDataSource:self];
    [_rightTableView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:_rightTableView];
    
    [self loadAllProvinces];
    [self loadAllCitys];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadAllCitys {
    [[ServiceRequest shared] scanCityListWithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    NSArray *citys = [ScanCityInfo initWithArray:array];
                    allCitys = citys;
                    [_rightTableView reloadData];
                }
            }
        }
    }];
}

- (void)loadAllProvinces {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] scanProvinceListWithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    NSArray *provinces = [ScanProviceInfo initWithArray:array];
                    allProvinces = provinces;
                    [_leftTableView reloadData];
                }
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return [allProvinces count];
    }
    return [citysArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    if (tableView == _leftTableView) {
        ScanProviceInfo *info = allProvinces[indexPath.row];
        cell.textLabel.text = info.name;
    } else if (tableView == _rightTableView) {
        ScanCityInfo *info = citysArray[indexPath.row];
        cell.textLabel.text = info.cityName;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        [self getCitysByProvince:allProvinces[indexPath.row]];
    } else if (tableView == _rightTableView) {
        ScanCityInfo *info = citysArray[indexPath.row];
        NSLog(@"%@", info.cityName);
        if ([self.delegate respondsToSelector:@selector(selectedCityId:andName:)]) {
            [self.delegate selectedCityId:info.cid andName:info.cityName];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)getCitysByProvince:(ScanProviceInfo *)info {
    [citysArray removeAllObjects];
    for (int i = 0; i < [allCitys count]; i++) {
        ScanCityInfo *cInfo = allCitys[i];
        if ([info.pid isEqualToNumber:cInfo.provinceId]) {
            [citysArray addObject:cInfo];
        }
    }
    [_rightTableView reloadData];
}
@end
