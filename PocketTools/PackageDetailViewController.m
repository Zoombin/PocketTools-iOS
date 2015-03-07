//
//  PackageDetailViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PackageDetailViewController.h"
#import "PostInfo.h"

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
    NSMutableString *str = [@"" mutableCopy];
    for (int i = 0; i < [resultArray count]; i++) {
        PostInfo *info = resultArray[i];
        [str appendFormat:@"时间 : %@\n状态 : %@\n\n", info.datetime, info.remark];
    }
    [_contentTextView setText:str];
}

@end
