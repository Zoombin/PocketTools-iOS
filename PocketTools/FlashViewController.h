//
//  FlashViewController.h
//  PocketTools
//
//  Created by yc on 15-3-2.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FlashViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIButton *button;
@property (nonatomic, assign) BOOL btnStatus;
@property (nonatomic, strong) UIImage *btnFlashon;
@property (nonatomic, strong) UIImage *btnFlashoff;
@property (nonatomic,strong) AVCaptureDevice *device;
- (IBAction)btnclick:(id)sender;
@end
