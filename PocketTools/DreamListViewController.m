//
//  DreamListViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "DreamListViewController.h"
#import "DreamTypeSecondViewController.h"
#import "DreamType.h"
#import "DreamSearchViewController.h"

@interface DreamListViewController ()

@end

@implementation DreamListViewController {
    NSMutableArray *resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"周公解梦", nil);
    resultArray = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [_searchButton.layer setCornerRadius:6.0];
    [_searchButton.layer setMasksToBounds:YES];
    
    [self loadTypeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonClicked:(id)sender {
    [self search];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self search];
    return YES;
}

- (void)search {
    if ([_searchTextField.text length] == 0) {
        [self displayHUDTitle:nil message:@"请输入内容" duration:DELAY_TIMES];
        return;
    }
    DreamSearchViewController *viewCtrl = [DreamSearchViewController new];
    viewCtrl.keyWord = _searchTextField.text;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)loadTypeList {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] dreamTypeList:@"0" withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                NSLog(@"%@", resultInfo.result);
                [resultArray addObjectsFromArray:[DreamType initWithArray:(NSArray *)resultInfo.result]];
                [_tableView reloadData];
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultArray count];
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
    DreamType *type = resultArray[indexPath.row];
    cell.textLabel.text = type.name;
    cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DreamType *type = resultArray[indexPath.row];
//    DreamTypeSecondViewController *viewCtrl = [DreamTypeSecondViewController new];
//    viewCtrl.name = type.name;
//    viewCtrl.title = type.name;
//    [self.navigationController pushViewController:viewCtrl animated:YES];
}

@end
