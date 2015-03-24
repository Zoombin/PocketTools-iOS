//
//  BackgroundViewController.m
//  PocketTools
//
//  Created by yc on 15-3-24.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "BackgroundViewController.h"

@interface BackgroundViewController ()

@end

@implementation BackgroundViewController {
    NSArray *backgrounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    backgrounds = @[@"background1", @"background2", @"background3"];
    NSString *background = [[ServiceRequest shared] getBackground];
    if ([backgrounds containsObject:background]) {
        NSInteger index = [backgrounds indexOfObject:background];
        [self saveBkg:index];
    }
    self.title = @"修改皮肤";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bkgButtonClicked:(id)sender {
    NSInteger tag = [sender tag];
    [self saveBkg:tag];
}

- (void)saveBkg:(NSInteger)index {
    [[ServiceRequest shared] saveBackGround:backgrounds[index]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:backgrounds[index]]]];
    
    [self allUnSelected];
    [self selectWithIndex:index];
}

- (void)selectWithIndex:(NSInteger)index {
    if (index == 0) {
        [_button1.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_button1.layer setBorderWidth:1];
    } else if (index == 1) {
        [_button2.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_button2.layer setBorderWidth:1];
    } else if (index == 2) {
        [_button3.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_button3.layer setBorderWidth:1];
    }
}

- (void)allUnSelected {
    [_button1.layer setBorderColor:[UIColor clearColor].CGColor];
    [_button2.layer setBorderColor:[UIColor clearColor].CGColor];
    [_button3.layer setBorderColor:[UIColor clearColor].CGColor];
}
@end
