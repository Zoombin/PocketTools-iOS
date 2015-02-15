//
//  MBProgressHUD+PN.h
//  Pods
//
//  Created by Mac on 15-2-11.
//
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (PN)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

+ (void)showloadview;
@end
