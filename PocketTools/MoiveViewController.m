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
    NSInteger index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"电影", nil);
    [_areaSegmetedControl addTarget:self action:@selector(areaValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self leftButtonClicked:nil];
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

- (IBAction)leftButtonClicked:(id)sender {
    index = 0;
    [self loadAreaMoview:@"CN"];
    [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height - _areaView.frame.size.height)];
    [_areaView setHidden:NO];
    [_tableView setTableHeaderView:_leftHeaderView];
}

- (IBAction)rightButtonClicked:(id)sender {
    index = 1;
    [self loadWebMovie];
    [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height + _areaView.frame.size.height)];
    [_areaView setHidden:YES];
    [_tableView setTableHeaderView:_rightHeaderView];
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
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    MovieInfo *info = movieArray[indexPath.row];
    if (index == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@", info.rid, info.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"总票房:%@", info.tboxoffice];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", info.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"票房:%@", info.boxoffice];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
