//
//  PackageDetailViewController.h
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackageDetailViewController : PTViewController

@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) NSString *postNum;
@property (nonatomic, strong) NSString *postCompany;
@end
