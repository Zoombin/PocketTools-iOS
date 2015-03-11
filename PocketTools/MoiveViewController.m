//
//  MoiveViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MoiveViewController.h"
#import "MovieInfo.h"

@interface MoiveViewController ()

@end

@implementation MoiveViewController {
    NSArray *movieArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"电影", nil);
    [_allSegmetedControl addTarget:self action:@selector(allValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_areaSegmetedControl addTarget:self action:@selector(areaValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = _allSegmetedControl;
    [self allValueChanged:nil];
}

- (void)allValueChanged:(id)sender {
    if (_allSegmetedControl.selectedSegmentIndex == 0) {
        [self loadAreaMoview:@"CN"];
        [_tableView setTableHeaderView:_areaSegmetedControl];
        _areaSegmetedControl.selectedSegmentIndex = 0;
    } else {
        [self loadWebMovie];
        [_tableView setTableHeaderView:nil];
    }
}

- (void)areaValueChanged:(id)sender {
//    CN US UK
    if (_areaSegmetedControl.selectedSegmentIndex == 0) {
        [self loadAreaMoview:@"CN"];
    } else if (_areaSegmetedControl.selectedSegmentIndex == 1) {
        [self loadAreaMoview:@"US"];
    } else if (_areaSegmetedControl.selectedSegmentIndex == 2) {
        [self loadAreaMoview:@"UK"];
    }
}

- (void)loadWebMovie {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] netBuyMoiveWithBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array count] > 0) {
                    movieArray = [MovieInfo initWithArray:array];
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

- (void)loadAreaMoview:(NSString *)area {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] newestMovieRank:area withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array count] > 0) {
                    movieArray = [MovieInfo initWithArray:array];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [movieArray count];
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
    MovieInfo *info = movieArray[indexPath.row];
    if (_allSegmetedControl.selectedSegmentIndex == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", info.rid, info.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"总票房:%@", info.tboxoffice];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", info.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"价格:%@", info.boxoffice];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
