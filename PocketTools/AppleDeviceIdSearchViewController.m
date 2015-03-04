//
//  AppleDeviceIdSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "AppleDeviceIdSearchViewController.h"
#import "AppleInfo.h"

#define DEFAULT_STRING @"序列号位置:通用->关于本机->序列号->点击粘贴"

@interface AppleDeviceIdSearchViewController ()

@end

@implementation AppleDeviceIdSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"苹果保修查询", nil);
    
    if ([[ServiceRequest shared] getAppId]) {
        _snTextField.text = [[ServiceRequest shared] getAppId];
        [self loadAppleInfo];
    } else {
        [_snTextField becomeFirstResponder];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadAppleInfo];
    return YES;
}

- (void)loadAppleInfo {
    if ([_snTextField.text isEqualToString:@""]) {
        NSLog(@"请输入苹果码");
        [self displayHUDTitle:nil message:@"请输入苹果码" duration:DELAY_TIMES];
        return;
    }
    [_snTextField resignFirstResponder];
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] appleInfo:_snTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                NSLog(@"数据获取成功!");
                [self hideHUD:YES];
                AppleInfo *appleInfo = [[AppleInfo alloc] initWithAttributes:resultInfo.result];
                [[ServiceRequest shared] saveAppID:_snTextField.text];
                [self showContentWithAppleInfo:appleInfo];
            } else {
                NSLog(@"数据获取失败");
                [self displayHUDTitle:nil message:@"获取失败" duration:DELAY_TIMES];
                _contentTextView.text = DEFAULT_STRING;
            }
        } else {
            NSLog(@"网络异常");
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
            _contentTextView.text = DEFAULT_STRING;
        }
    }];
}

- (void)showContentWithAppleInfo:(AppleInfo *)appleInfo
{
    NSString *content = [NSString stringWithFormat:@"设备型号: %@\n\n设备序列号: %@\n\nIMEI号: %@\n\n激活状态: %@\n\n保修状态: %@\n\n保修到期: %@\n\n电话支持到期: %@\n\n电话支持状态: %@\n\n生产工厂: %@\n\n生产时间: %@ 至 %@", appleInfo.phoneModel, appleInfo.serialNumber , appleInfo.imeiNumber, appleInfo.active, appleInfo.warrantyStatus, appleInfo.warranty, appleInfo.teleSupport, appleInfo.teleSupportStatus, appleInfo.madeArea, appleInfo.startDate, appleInfo.endDate];
    _contentTextView.text = content;
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
