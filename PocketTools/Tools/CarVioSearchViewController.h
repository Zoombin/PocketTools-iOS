//
//  CarVioSearchViewController.h
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarVioSearchViewController : PTViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIPickerView *picker;
@property (nonatomic, weak) IBOutlet UIView *pickerView;
@property (nonatomic, weak) IBOutlet UIButton *cityButton;
@property (nonatomic, weak) IBOutlet UIButton *carTypeButton;
@property (nonatomic, weak) IBOutlet UITextField *carNumTextField;

@property (nonatomic, weak) IBOutlet UITextField *engineTextField;
@property (nonatomic, weak) IBOutlet UITextField *carFrameTextField;
@property (nonatomic, weak) IBOutlet UITextField *registTextField;
@property (nonatomic, weak) IBOutlet UILabel *engineLabel;
@property (nonatomic, weak) IBOutlet UILabel *carFrameLabel;
@property (nonatomic, weak) IBOutlet UILabel *registLabel;

@property (nonatomic, weak) IBOutlet UIButton *searchButton;
@property (nonatomic, weak) IBOutlet UILabel *line1;
@property (nonatomic, weak) IBOutlet UILabel *line2;
@property (nonatomic, weak) IBOutlet UILabel *line3;
@property (nonatomic, weak) IBOutlet UILabel *line4;
@property (nonatomic, weak) IBOutlet UILabel *line5;
@property (nonatomic, weak) IBOutlet UILabel *line6;

- (IBAction)sureButtonClicked:(id)sender;
- (IBAction)searchButtonClicked:(id)sender;
- (IBAction)seletTypeButtonClicked:(id)sender;
- (IBAction)selectCityButtonClicked:(id)sender;
@end
