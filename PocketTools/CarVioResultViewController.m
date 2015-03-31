//
//  CarVioResultViewController.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CarVioResultViewController.h"
#import "WZDetailInfo.h"
#import "CarCell.h"
#import "WZInfo.h"

@interface CarVioResultViewController ()

@end

@implementation CarVioResultViewController {
    NSMutableArray *wzArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"查询结果", nil);
    wzArrays = [NSMutableArray array];
    NSLog(@"City=%@ Num=%@ Type=%@", _cityName, _carNum, _carType);
    [self search];
}

- (void)search {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchWZ:_cityName carNum:_carNum carType:_carType carFrame:_carFrameNum engineNum:_engineNum registNum:_registNum withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                WZInfo *wzInfo = [[WZInfo alloc] initWithAttributes:resultInfo.result];
                if ([wzInfo.lists count] > 0) {
                    [self hideHUD:YES];
                    [wzArrays addObjectsFromArray:wzInfo.lists];
                    [_tableView reloadData];
                } else {
                    [self displayHUDTitle:nil message:@"未找到违章记录" duration:DELAY_TIMES];
                }
            } else {
                [self displayHUDTitle:nil message:@"获取数据失败" duration:DELAY_TIMES];
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
    return [wzArrays count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    CarCell *cell = (CarCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CarCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    WZDetailInfo *entity = wzArrays[indexPath.row];
    cell.timeLabel.text = [NSString stringWithFormat:@"时间 : %@", entity.date];
    cell.locationLabel.text = [NSString stringWithFormat:@"地点 : %@", entity.area];
    cell.locationLabel.numberOfLines = 0;
    cell.locationLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.locationLabel sizeToFit];
    cell.scoreLabel.text = [NSString stringWithFormat:@"扣分 : %@\t罚款 : %@\t是否已处理 : %@", entity.fen, entity.money, [entity.handled integerValue] == 1 ? @"是" : @"否"];
    cell.reasonLabel.text = [NSString stringWithFormat:@"原因 : %@", entity.act];
    cell.reasonLabel.numberOfLines = 0;
    cell.reasonLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.reasonLabel sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
