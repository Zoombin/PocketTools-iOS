//
//  PhotoPasswordViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PhotoPasswordViewController.h"
#import "DMPasscode.h"
#import "ImageScanViewController.h"

@interface PhotoPasswordViewController ()

@end

@implementation PhotoPasswordViewController {
    UIButton *localPhotoButton;
    UIButton *takePhotoButton;
    UIButton *removeButton;
    UIButton *saveButton;
    NSMutableArray *tmpArray;
    NSMutableArray *selectedArray;
    BOOL isEditing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"私密相册", nil);
    tmpArray = [NSMutableArray array];
    selectedArray = [NSMutableArray array];
    isEditing = NO;
    [self addButtons];
    if ([[ServiceRequest shared] getPassword]) {
        [self checkPassword];
    } else {
        [self showPasswordView];
    }
}

- (void)showButton {
    localPhotoButton.hidden = isEditing;
    takePhotoButton.hidden = isEditing;
    removeButton.hidden = !isEditing;
    saveButton.hidden = !isEditing;
}

- (void)addButtons {
    CGFloat buttonWidth = [UIScreen mainScreen].bounds.size.width / 2;
    CGFloat buttonHeight = _bottomView.frame.size.height;
    
     localPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [localPhotoButton setFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [localPhotoButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [localPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    localPhotoButton.contentMode = UIViewContentModeCenter;
    [localPhotoButton setImage:[UIImage imageNamed:@"btn_secret_library"] forState:UIControlStateNormal];
    [localPhotoButton addTarget:self action:@selector(localPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:localPhotoButton];
    
    takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [takePhotoButton setFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
    [takePhotoButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [takePhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [takePhotoButton setImage:[UIImage imageNamed:@"btn_secret_camera"] forState:UIControlStateNormal];
    [takePhotoButton addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:takePhotoButton];
    
     removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [removeButton setFrame:CGRectMake(0, 0, buttonWidth, buttonHeight)];
    [removeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [removeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(deletePhoto) forControlEvents:UIControlEventTouchUpInside];
    [removeButton setImage:[UIImage imageNamed:@"btn_secret_delete"] forState:UIControlStateNormal];
    [_bottomView addSubview:removeButton];
    
     saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setFrame:CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)];
    [saveButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(saveToAlum) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setImage:[UIImage imageNamed:@"btn_secret_save"] forState:UIControlStateNormal];
    [_bottomView addSubview:saveButton];
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonClick)];
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    isEditing = NO;
    [self showButton];
}

- (void)editButtonClick {
    isEditing = !isEditing;
    if (!isEditing) {
        [self removeAllSelectedImageView];
    }
    [self showButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkPassword {
    [DMPasscode showPasscodeInViewController:self completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"密码对啦!");
            [self loadImageList];
        } else {
            NSLog(@"密码不对!");
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)showPasswordView {
    [DMPasscode setupPasscodeInViewController:self completion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"设置成功");
            [[ServiceRequest shared] savePassword:@"1"];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void)loadImageList {
    for (UIView *v in _scrollView.subviews) {
        [v removeFromSuperview];
    }
    [tmpArray removeAllObjects];
    [selectedArray removeAllObjects];
    NSArray *arr = [[ServiceRequest shared] getPhotoList];
    if([arr count] > 0) {
        int line = 0;
        int index = 0;
        CGFloat offSetX = 5;
        CGFloat imageWidth = ([UIScreen mainScreen].bounds.size.width - (offSetX * 5)) / 4;
        CGFloat imageHeight = 100;
        for (int i = 0; i < [arr count]; i++) {
            if (i != 0 && i % 4 == 0) {
                line ++;
                index = 0;
            }
            NSString *fileName = arr[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(offSetX * (index + 1) + (index * imageWidth), 10 * (line + 1) + line * imageHeight, imageWidth, imageHeight)];
            [imageView setTag:i];
            [imageView setUserInteractionEnabled:YES];
            [imageView setBackgroundColor:[UIColor lightGrayColor]];
            [imageView setImage:[self getImageByFileName:fileName]];
            
            UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] init];
            [gesture addTarget:self action:@selector(selectedClicked:)];
            [imageView addGestureRecognizer:gesture];
            
            [_scrollView addSubview:imageView];
            [tmpArray addObject:imageView];
            index++;
        }
        [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, (line + 1) * (imageHeight + 10))];
    }
}

- (void)selectedClicked:(UITapGestureRecognizer *)gesture {
    UIImageView *imageView = tmpArray[gesture.view.tag];
    if (!isEditing) {
        ImageScanViewController *viewCtrl = [ImageScanViewController new];
        viewCtrl.image = imageView.image;
        [BackButtonTool addBackButton:viewCtrl];
        [self.navigationController pushViewController:viewCtrl animated:YES];
        return;
    }
    if (imageView.alpha == 1.0) {
        imageView.alpha = 0.5;
        [selectedArray addObject:imageView];
    } else {
        imageView.alpha = 1.0;
        if ([selectedArray containsObject:imageView]) {
            [selectedArray removeObject:imageView];
        }
    }
}

- (void)removeAllSelectedImageView {
    for (UIView *v in selectedArray) {
        v.alpha = 1.0;
    }
    [selectedArray removeAllObjects];
}

- (void)deletePhoto {
    if ([selectedArray count] > 0) {
        NSArray *fileNames = [[ServiceRequest shared] getPhotoList];
        for (UIImageView *imageView in selectedArray) {
            NSString *fileName = fileNames[imageView.tag];
            [self removeFile:fileName];
        }
        [self displayHUDTitle:nil message:@"删除成功!"];
        [self loadImageList];
    }
}

- (void)saveToAlum {
    if ([selectedArray count] > 0) {
        for (UIImageView *imageView in selectedArray) {
            UIImageWriteToSavedPhotosAlbum(imageView.image, nil, nil, nil);
        }
        [self displayHUDTitle:nil message:@"保存成功!"];
        [self loadImageList];
    }
    
}

- (void)takePhoto
{
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        [self displayHUDTitle:nil message:@"模拟器不能拍照"];
        return;
    }
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", image);
    if ([self saveImage:image]) {
        [self loadImageList];
        [self displayHUDTitle:nil message:@"保存成功!"];
    } else {
        [self displayHUDTitle:nil message:@"保存失败!"];
    }
}

- (BOOL)saveImage:(UIImage *)image {
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask,YES);
    NSString *documentPath =[documentPaths objectAtIndex:0];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSString *FileName= [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"Image_%@.png", dateString]];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if ([data writeToFile:FileName atomically:YES]) {
        [[ServiceRequest shared] savePhotoName:FileName];
        return YES;
    }
    return NO;
}

- (UIImage *)getImageByFileName:(NSString *)fileName {
    NSData *filedata= [NSData dataWithContentsOfFile:fileName options:0 error:NULL];//从FileName中读取出数据
    UIImage *image = [UIImage imageWithData:filedata];
    return image;
}

- (BOOL)removeFile:(NSString *)fileName {
    NSFileManager *manager = [[NSFileManager alloc] init];
    if([manager removeItemAtPath:fileName error:nil]) {
        NSLog(@"删除成功");
        [[ServiceRequest shared] removePhotoName:fileName];
        return YES;
    }
    NSLog(@"删除失败");
    if (![self checkHasExist:fileName]) {
        NSLog(@"文件不存在!");
       [[ServiceRequest shared] removePhotoName:fileName];
    }
    return NO;
}

- (BOOL)checkHasExist:(NSString *)fileName {
    NSFileManager *manager = [[NSFileManager alloc] init];
    if ([manager fileExistsAtPath:fileName]) {
        NSLog(@"文件存在");
        return YES;
    }
    return NO;
}





@end
