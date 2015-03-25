//
//  MirrorViewController.m
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "MirrorViewController.h"

@interface MirrorViewController ()

@end

@implementation MirrorViewController {
    UIImagePickerController *imagePicker;
    UIImage *currentImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"镜子", nil);
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"无摄像头");
        return;
    }
    [self showCamera];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)showCamera {
     imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setCameraDevice:UIImagePickerControllerCameraDeviceFront];
    [imagePicker setAllowsEditing:NO];
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:NO completion:nil];
}

- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    currentImage = image;
    [self showSaveAlertView];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.cancelButtonIndex == buttonIndex) {
        return;
    }
    [self displayHUD:@"保存中..."];
    UIImageWriteToSavedPhotosAlbum(currentImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)showSaveAlertView {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否保存图片?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alertView show];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil;
    if(error != NULL) {
        msg = @"保存图片失败";
        [self displayHUDTitle:nil message:@"保存图片失败"];
    }else {
        msg = @"保存图片成功";
        [self displayHUDTitle:nil message:@"保存图片成功"];
    }
    [self displayHUDTitle:nil message:msg duration:DELAY_TIMES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"取消");
    [imagePicker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
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
