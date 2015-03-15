//
//  UnitViewController.h
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) IBOutlet UITextField *leftTextView;
@property (nonatomic, weak) IBOutlet UITextField *rightTextView;
@property (nonatomic, weak) IBOutlet UILabel *centerLabel;
@end
