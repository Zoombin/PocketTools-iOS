//
//  WeatherCitiesViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherCitiesViewController.h"

@interface WeatherCitiesViewController ()

@end

@implementation WeatherCitiesViewController {
    NSMutableArray *cityArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"选择城市", nil);
    cityArray = [NSMutableArray array];
    [self loadCity];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadCity {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] loadAirCityListWithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    [cityArray addObjectsFromArray:array];
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

- (void)selectCity:(NSInteger)index {
    if ([self.delegate respondsToSelector:@selector(selectCityName:)]) {
        NSString *name = cityArray[index][@"city"];
        [self.delegate selectCityName:name];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cityArray count];
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
    NSDictionary *info = cityArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", info[@"city"], info[@"district"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectCity:indexPath.row];
}

@end
