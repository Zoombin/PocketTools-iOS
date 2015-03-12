//
//  PlaneSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-3-12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PlaneSearchViewController.h"

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
    _startTextField.text = @"上海";
    _endTextField.text = @"北京";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)sureButtonClicked:(id)sender {
    if ([_startTextField.text length] == 0 && [_endTextField.text length] == 0) {
        [self displayHUDTitle:nil message:@"起点或终点不能为空!" duration:DELAY_TIMES];
        return;
    }
    [[ServiceRequest shared] planceSearch:_startTextField.text endCity:_endTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            NSLog(@"%@", result);
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
