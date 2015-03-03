//
//  PhoneSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PhoneSearchViewController.h"
#import "PhoneInfo.h"

@interface PhoneSearchViewController ()

@end

@implementation PhoneSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"来电号码查询", nil);
    // Do any additional setup after loading the view from its nib.
    [_phoneTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadPhoneInfo];
    return YES;
}

- (void)loadPhoneInfo {
    if ([_phoneTextField.text isEqualToString:@""]) {
        NSLog(@"请输入手机号");
        [self displayHUDTitle:nil message:@"请输入手机号" duration:DELAY_TIMES];
        return;
    }
    [_phoneTextField resignFirstResponder];
    [[ServiceRequest shared] phoneSearch:_phoneTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                NSLog(@"数据获取成功!");
                PhoneInfo *appleInfo = [[PhoneInfo alloc] initWithAttributes:resultInfo.result];
                [self showContentWithPhoneInfo:appleInfo];
            } else {
                NSLog(@"数据获取失败");
            }
        } else {
            NSLog(@"网络异常");
        }
    }];
}

- (void)showContentWithPhoneInfo:(PhoneInfo *)phoneInfo
{
    NSString *content = [NSString stringWithFormat:@"省份: %@\n\n城市: %@\n\n区号: %@\n\n邮编: %@\n\n运营商: %@\n\n卡类型: %@", phoneInfo.province, phoneInfo.city, phoneInfo.areacode, phoneInfo.zip, phoneInfo.company, phoneInfo.card];
    _contentTextView.text = content;
    _contentTextView.numberOfLines = 0;
    _contentTextView.lineBreakMode = NSLineBreakByWordWrapping;
    [_contentTextView sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
