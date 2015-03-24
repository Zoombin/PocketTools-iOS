//
//  DreamSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "DreamSearchViewController.h"
#import "DreamDetailViewController.h"
#import "DreamInfo.h"

@interface DreamSearchViewController ()

@end

@implementation DreamSearchViewController {
    NSArray *dreamArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _keyWord;
    [self search];
}

- (void)search {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchDreamByKey:_keyWord withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                NSLog(@"%@", resultInfo.result);
                NSArray *array = (NSArray *)resultInfo.result;
                if ([array isKindOfClass:[NSArray class]]) {
                    [self hideHUD:YES];
                    dreamArray = [DreamInfo initWithArray:array];
                    [_tableView reloadData];
                } else {
                    [self displayHUDTitle:nil message:@"未查到相关信息"];
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
    return [dreamArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    DreamInfo *info = dreamArray[indexPath.row];
    cell.textLabel.text = info.title;
    cell.detailTextLabel.text = info.des;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DreamInfo *info = dreamArray[indexPath.row];
    DreamDetailViewController *detailViewCtrl = [DreamDetailViewController new];
    detailViewCtrl.title = info.title;
    if ([info.list count] > 0) {
        detailViewCtrl.content = info.list[0];
    }
    [BackButtonTool addBackButton:detailViewCtrl];
    [self.navigationController pushViewController:detailViewCtrl animated:YES];
    
}

@end
