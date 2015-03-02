//
//  FlashViewController.m
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "FlashViewController.h"

#define  mainH [UIScreen mainScreen].bounds.size.height
#define  mainW [UIScreen mainScreen].bounds.size.width

@implementation FlashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"手电筒", nil);
    //手电开关切换按钮
    _btnFlashon = [UIImage imageNamed:@"btn_flashlite_on"];
    _btnFlashoff = [UIImage imageNamed:@"btn_flashlite_off"];
    self.btnStatus = YES;
    
    //找到一个合适的AVCaptureDevice
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![_device hasFlash]) {
        //判断是否有闪光灯
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备不支持手电筒功能" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
    }
    [_button setFrame:CGRectMake((mainW / 2) - _button.frame.size.width / 2, _button.frame.origin.y, _button.frame.size.width, _button.frame.size.height)];
    //默认点击
    [self btnclick:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self turnOffLed:YES];
}

//手电开关切换按钮点击事件
- (IBAction)btnclick:(id)sender
{
    if (self.btnStatus == YES) {
        [self.button setImage:_btnFlashon forState:UIControlStateNormal];
        [self turnOnLed:YES];
    }
    else{
        [self.button setImage:_btnFlashoff forState:UIControlStateNormal];
        [self turnOffLed:YES];
    }
    self.btnStatus = !self.btnStatus;
}
//打开手电筒
- (void)turnOnLed:(BOOL)update
{
    [_device lockForConfiguration:nil];
    [_device setTorchMode:AVCaptureTorchModeOn];
    [_device unlockForConfiguration];
}
//关闭手电筒
- (void)turnOffLed:(BOOL)update
{
    [_device lockForConfiguration:nil];
    [_device setTorchMode:AVCaptureTorchModeOff];
    [_device unlockForConfiguration];
}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
