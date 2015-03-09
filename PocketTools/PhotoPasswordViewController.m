//
//  PhotoPasswordViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PhotoPasswordViewController.h"

@interface PhotoPasswordViewController ()

@end

@implementation PhotoPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    TouchIDPass *touch = [[TouchIDPass alloc] init];
    touch.delegate = self;
    [touch touch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)touchIDPass:(TouchIDPass *)touchIDPass tokenValid:(NSString *)keyWithMD5 {
    return YES;
}

- (void)touchIDPass:(TouchIDPass *)touchIDPass touchResult:(TouchIDPassResult)code {
    if (code == TouchIDPassResultSuccess) {
        
    } else if (code == TouchIDPassResultUnauthorize) {
        
    } else if (code == TouchIDPassResultFingerFailed) {
        NSLog(@"手指验证失败");
    } else if (code == TouchIDPassResultUnsupportDevice) {
        NSLog(@"不支持的设备");
    }
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
