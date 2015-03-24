//
//  TrainViewController.m
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "TrainViewController.h"
#import "TrainCell.h"
#import "StationInfo.h"
#import "StationCell.h"
#import "TrainInfo.h"
#import "STSInfo.h"

@interface TrainViewController ()

@end

@implementation TrainViewController {
    NSMutableArray *trianInfoArray;
    NSArray *typeNames;
    NSArray *typeSimple;
    NSString *currentType;
    NSInteger index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 0;
    trianInfoArray = [NSMutableArray array];
    typeSimple = @[@"G", @"K", @"T", @"D", @"Z", @"Q"];
    typeNames = @[@"高速动车", @"快速", @"空调特快", @"动车组", @"直达特快", @"其他"];
    self.title = @"火车订票";
    [self leftButtonClicked:nil];
    [_searchButton.layer setCornerRadius:6.0];
    [_searchButton.layer setMasksToBounds:YES];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)leftButtonClicked:(id)sender {
    index = 0;
    [trianInfoArray removeAllObjects];
    [_tableView reloadData];
    [_tableView setTableHeaderView:_firstHeader];
}

- (IBAction)rightButtonClicked:(id)sender {
    index = 1;
    [trianInfoArray removeAllObjects];
    [_tableView reloadData];
    [_tableView setTableHeaderView:_searchView];
}

- (IBAction)replaceButtonClicked:(id)sender {
    NSString *from = _startTextField.text;
    NSString *to = _endTextField.text;
    _startTextField.text = to;
    _endTextField.text = from;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_searchBar resignFirstResponder];
    if ([searchBar.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"请输入内容!" duration:DELAY_TIMES];
        return;
    }
    [trianInfoArray removeAllObjects];
    [_tableView reloadData];
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] trainTimesSearch:_searchBar.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                TrainInfo *info = [[TrainInfo alloc] initWithAttributes:resultInfo.result[@"train_info"]];
                [trianInfoArray addObject:info];
                [_tableView reloadData];
                NSArray *array = resultInfo.result[@"station_list"];
                if ([array isKindOfClass:[NSArray class]]) {
                    [trianInfoArray addObjectsFromArray:[StationInfo initWithArray:array]];
                    [_tableView reloadData];
                }
            } else {
                [self displayHUDTitle:nil message:@"查询失败!" duration:DELAY_TIMES];
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

- (IBAction)trainTypeButtonClicked:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = @"选择火车类别";
    [actionSheet addButtonWithTitle:@"全部"];
    [actionSheet addButtonWithTitle:@"高速动车"];
    [actionSheet addButtonWithTitle:@"快速"];
    [actionSheet addButtonWithTitle:@"空调特快"];
    [actionSheet addButtonWithTitle:@"动车组"];
    [actionSheet addButtonWithTitle:@"直达特快"];
    [actionSheet addButtonWithTitle:@"其他"];
    [actionSheet addButtonWithTitle:@"取消"];
    [actionSheet setCancelButtonIndex:7];
    [actionSheet setDelegate:self];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    if (buttonIndex != 0) {
        currentType = typeSimple[buttonIndex - 1];
        [_trainTypeBtn setTitle:typeNames[buttonIndex - 1] forState:UIControlStateNormal];
    } else {
        currentType = nil;
        _trainTypeBtn.titleLabel.text = @"全部";
        [_trainTypeBtn setTitle:@"全部" forState:UIControlStateNormal];
    }
}

- (IBAction)searchButtonClicked:(id)sender {
    if ([_startTextField.text isEqualToString:@""] || [_endTextField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"请输入内容!" duration:DELAY_TIMES];
        return;
    }
    [trianInfoArray removeAllObjects];
    [_tableView reloadData];
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchTrainByStart:_startTextField.text end:_endTextField.text trainType:currentType withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSArray *array = resultInfo.result[@"data"];
                if ([array isKindOfClass:[NSArray class]]) {
                    [trianInfoArray addObjectsFromArray:[STSInfo initWithArray:array]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [trianInfoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (index == 1) {
        if (indexPath.row == 0) {
            return 70;
        } else {
            return 110;
        }
    } else {
        return 70;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    if (index == 1) {
        if (indexPath.row == 0) {
            TrainCell *cell = (TrainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"TrainCell" owner:nil options:nil];
                cell = [nibs lastObject];
            }
            TrainInfo *train = trianInfoArray[indexPath.row];
            cell.locationLabel.text = [NSString stringWithFormat:@"%@ %@ 到 %@", train.name, train.start, train.end];
            cell.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@ 里程 %@", train.starttime, train.endtime, train.mileage];
            return cell;
        } else {
            StationCell *cell = (StationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"StationCell" owner:nil options:nil];
                cell = [nibs lastObject];
            }
            StationInfo *train = trianInfoArray[indexPath.row];
            cell.stationDescribe.text = [NSString stringWithFormat:@"%@ 到达时间:%@", train.station_name, train.arrived_time];
            cell.fseartLabel.text = [NSString stringWithFormat:@"一等座:%@ 二等座:%@ 硬座:%@", train.   fsoftSeat, train.ssoftSeat, train.hardSead];
            cell.sseartLabel.text = [NSString stringWithFormat:@"软座:%@ 软卧:%@ 硬卧:%@", train.softSeat, train.softSleep, train.hardSleep];
            return cell;
        }
    } else {
        TrainCell *cell = (TrainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"TrainCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }
        STSInfo *train = trianInfoArray[indexPath.row];
        cell.locationLabel.text = [NSString stringWithFormat:@"%@ %@ 到 %@", train.trainOpp, train.start_staion, train.end_station];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@ ~ %@ 里程 %@", train.end_station, train.arrived_time, train.mileage];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
