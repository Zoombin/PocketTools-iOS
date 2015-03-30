//
//  PackageDetailViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PackageDetailViewController.h"
#import "PostInfo.h"
#import "PackageCell.h"

@interface PackageDetailViewController ()

@end

@implementation PackageDetailViewController {
    NSMutableArray *resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"快递状态", nil);
    resultArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [self getPackageResult];
}

- (void)getPackageResult {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] postmanSearch:_postCompany postnum:_postNum withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                [resultArray addObjectsFromArray:[[[PostInfo initWithArray:resultInfo.result[@"list"]] reverseObjectEnumerator] allObjects]];
                [self showInfo];
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

- (void)showInfo {
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    PackageCell *cell = (PackageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PackageCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    PostInfo *entity = resultArray[indexPath.row];
    cell.timeLabel.text = [NSString stringWithFormat:@"时间 : %@", entity.datetime];
    cell.contentLabel.text = [NSString stringWithFormat:@"状态 : %@", entity.remark];;
    cell.contentLabel.numberOfLines = 0;
    cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [cell.contentLabel sizeToFit];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
