//
//  PN_Flash_C.m
//  PocketTool
//
//  Created by Mac on 15-2-11.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Flash_C.h"
#import <AVFoundation/AVFoundation.h>
@interface PN_Flash_C ()
//手电开关切换按钮
@property (weak,nonatomic) UIButton *button;
// 状态标识
@property (nonatomic, assign) BOOL btnStatus;
// 开
@property (nonatomic, strong) UIImage *btnFlashon;
// 关
@property (nonatomic, strong) UIImage *btnFlashoff;

@property (nonatomic,strong) AVCaptureDevice *device;
@end

@implementation PN_Flash_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //手电开关切换按钮
    _btnFlashon = [UIImage imageNamed:@"btn_flashlite_on"];
    _btnFlashoff = [UIImage imageNamed:@"btn_flashlite_off"];
    self.btnStatus = YES;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    button.center = self.view.center;
    button.y = mainH*0.4;
    [button setImage:_btnFlashon forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(btnclick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    self.button = button;
    
    //找到一个合适的AVCaptureDevice
   _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![_device hasFlash]) {
        //判断是否有闪光灯
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备不支持手电筒功能" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alter show];
    }
    //返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    back.center = self.view.center;
    back.y = mainH*0.8;
    [back setImage:[UIImage imageWithName:@"btn_flashlite_close"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:back];
    
    //默认点击
    [self btnclick];
}

//手电开关切换按钮点击事件
- (void)btnclick
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
