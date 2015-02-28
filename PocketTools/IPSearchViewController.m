//
//  IPSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-2-28.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "IPSearchViewController.h"
#import "ServiceRequest.h"
#import "ServiceResult.h"
#import "IPInfo.h"

@interface IPSearchViewController ()

@end

@implementation IPSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"IP地址查询", nil);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadIpInfo];
    return YES;
}

- (void)loadIpInfo {
    if ([_ipTextField.text isEqualToString:@""]) {
        NSLog(@"请输入身份证号码");
        return;
    }
    [_ipTextField resignFirstResponder];
    [[ServiceRequest shared] ipSearch:_ipTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                NSLog(@"数据获取成功!");
                IPInfo *ipinfo = [[IPInfo alloc] initWithAttributes:resultInfo.result];
                [self showContentWithAppleInfo:ipinfo];
            } else {
                NSLog(@"数据获取失败");
                _contentTextView.text = @"";
            }
        } else {
            NSLog(@"网络异常");
            _contentTextView.text = @"";
        }
        
    }];
}

- (void)showContentWithAppleInfo:(IPInfo *)info
{
    NSString *content = [NSString stringWithFormat:@"地区: %@\n供应商: %@", info.area, info.location];
    _contentTextView.text = content;
}

@end
