//
//  IDCardSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-2-27.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "IDCardSearchViewController.h"
#import "ServiceRequest.h"
#import "ServiceResult.h"
#import "IDCardInfo.h"

@interface IDCardSearchViewController ()

@end

@implementation IDCardSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"身份证查询", nil);
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadAppleInfo];
    return YES;
}

- (void)loadAppleInfo {
    if ([_idCardTextField.text isEqualToString:@""]) {
        NSLog(@"请输入身份证号码");
        return;
    }
    [_idCardTextField resignFirstResponder];
    [[ServiceRequest shared] idCardSearch:_idCardTextField.text withBlocl:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                NSLog(@"数据获取成功!");
                IDCardInfo *cardInfo = [[IDCardInfo alloc] initWithAttributes:resultInfo.result];
                [self showContentWithAppleInfo:cardInfo];
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

- (void)showContentWithAppleInfo:(IDCardInfo *)info
{
    NSString *content = [NSString stringWithFormat:@"性别: %@\n生日: %@\n 地址: %@\n", info.sex, info.birthday, info.area];
    _contentTextView.text = content;
}

@end
