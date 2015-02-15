//
//  PN_Calculator_C.h
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//  科学计算器

#import <UIKit/UIKit.h>

#define kClear          10   // C
#define kDel            11	// DEL
#define kDevide         12	// ÷
#define kMultiply       13	// x
#define kSub            14	// -
#define kPlus           15	// +
#define kEqual          16	// =
#define kRightBracket   17  // )
#define kLeftBracket    18  // (
#define kDot            19	// .
#define kPower          20  // ^
#define kSin            21  // sin
#define kCos            22  // cos
#define kTan            23  // tan
#define kLog            24  // log 此处是以10为底
#define kLn             25  // ln
#define kRadical        26  // √ 根号
#define kMod            27  //  %求模


@interface PN_Calculator_C : UIViewController
<
UITableViewDataSource,
UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UILabel *totalResultLabel;
@property (weak, nonatomic) IBOutlet UITextField *resultText;


- (IBAction)tapAction:(UIButton *)sender;
@end
