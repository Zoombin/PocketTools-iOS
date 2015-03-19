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
    
    _contentTextView.numberOfLines = 0;
    _contentTextView.lineBreakMode = NSLineBreakByWordWrapping;
    
    [_searchButton.layer setCornerRadius:6.0];
    [_searchButton.layer setMasksToBounds:YES];
}

- (IBAction)searchButtonClicked:(id)sender {
    [self loadPhoneInfo];
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
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] phoneSearch:_phoneTextField.text withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                [self hideHUD:YES];
                PhoneInfo *appleInfo = [[PhoneInfo alloc] initWithAttributes:resultInfo.result];
                [self showContentWithPhoneInfo:appleInfo];
            } else {
                [self displayHUDTitle:nil message:@"数据获取失败!" duration:DELAY_TIMES];
            }
        } else {
           [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
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
