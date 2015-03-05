//
//  CarVioResultViewController.m
//  PocketTools
//
//  Created by yc on 15-3-5.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CarVioResultViewController.h"
#import "WZDetailInfo.h"
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

- (void)showData {
    NSString *contentString = @"";
    for (int i = 0; i < [wzArrays count]; i++) {
        WZDetailInfo *info = wzArrays[i];
        NSString *str = [NSString stringWithFormat:@"\t时间 : %@\t地点 : %@\n\n\t原因 : %@\n\n\t扣分 : %@分\t罚款 : %@元\n\n\t是否已处理 : %@\n\n\n", info.date, info.area, info.act, info.fen, info.money, [info.handled integerValue] == 1 ? @"已处理" : @"未处理"];
        contentString = [contentString stringByAppendingString:str];
    }
    _resultTextView.text = contentString;
}

- (void)search {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchWZ:_cityName carNum:_carNum carType:_carType carFrame:_carFrameNum engineNum:_engineNum registNum:_registNum withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            [self hideHUD:YES];
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                WZInfo *wzInfo = [[WZInfo alloc] initWithAttributes:resultInfo.result];
                if ([wzInfo.lists count] > 0) {
                    [wzArrays addObjectsFromArray:wzInfo.lists];
                    [self showData];
                } else {
                    _resultTextView.text = @"未查到违章记录";
                }
            } else {
                _resultTextView.text = @"未查到违章记录";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
