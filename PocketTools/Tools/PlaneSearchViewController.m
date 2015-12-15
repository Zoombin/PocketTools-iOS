//
//  PlaneSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PlaneSearchViewController.h"
#import "PlaneInfo.h"
#import "PlaneCell.h"

@interface PlaneSearchViewController ()

@end

@implementation PlaneSearchViewController {
    NSMutableArray *planesArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"航班动态", nil);
    planesArray = [NSMutableArray array];
    [_tableView setTableHeaderView:_headerView];
    [_searchButton.layer setCornerRadius:6.0];
    [_searchButton.layer setMasksToBounds:YES];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)replaceButtonClicked:(id)sender {
    NSString *from = _startTextField.text;
    NSString *to = _endTextField.text;
    _startTextField.text = to;
    _endTextField.text = from;
}

- (IBAction)sureButtonClicked:(id)sender {
    [_startTextField resignFirstResponder];
    [_endTextField resignFirstResponder];
    if ([_startTextField.text length] == 0 || [_endTextField.text length] == 0) {
        [self displayHUDTitle:nil message:@"起点或终点不能为空!" duration:DELAY_TIMES];
        return;
    }
    [self displayHUD:@"加载中..."];
    [planesArray removeAllObjects];
    [_tableView reloadData];
    [[ServiceRequest shared] planceSearch:_startTextField.text endCity:_endTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    [planesArray addObjectsFromArray:[PlaneInfo initWithArray:array]];
                    [_tableView reloadData];
                }
            } else {
                [self displayHUDTitle:nil message:@"搜索失败!" duration:DELAY_TIMES];
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
    return [planesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    PlaneCell *cell = (PlaneCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PlaneCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    PlaneInfo *plane = planesArray[indexPath.row];
    cell.airLineLabel.text = plane.Airline;
    cell.fightNumLabel.text = plane.FlightNum;
    cell.depLabel.text = plane.DepCity;
    cell.depTimeLabel.text = plane.DepTime;
    cell.arrLabel.text = plane.ArrCity;
    cell.arrTimeLabel.text = plane.ArrTime;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
