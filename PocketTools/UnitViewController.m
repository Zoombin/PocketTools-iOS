//
//  UnitViewController.m
//  PocketTools
//
//  Created by yc on 15-3-13.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "UnitViewController.h"
#import "UnitInfo.h"

@interface UnitViewController ()

@end

#define LENGTH 0
#define AREA 1
#define WEIGHT 2
#define VOLUME 3
#define TEMPERATURE 4

@implementation UnitViewController {
    NSMutableArray *localArrayList1;
    NSMutableArray *localArrayList2;
    NSMutableArray *localArrayList3;
    NSMutableArray *localArrayList4;
    NSMutableArray *localArrayList5;
    NSInteger leftIndex;
    NSInteger rightIndex;
    BOOL isRight;
    int type;
    NSArray *currentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"单位换算", nil);
    type = LENGTH;
    isRight = YES;
    [self initData];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerClicked)];
    [_centerLabel addGestureRecognizer:gesture];
    
    [_segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    _leftTextView.text = @"1";
    _rightTextView.text = @"1";
    [self valueChanged];
}

- (void)centerClicked {
    isRight = !isRight;
    [self showResult];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)valueChanged {
    if (_segmentedControl.selectedSegmentIndex == 0) {
        currentArray = localArrayList1;
        type = LENGTH;
    } else if (_segmentedControl.selectedSegmentIndex == 1) {
        currentArray = localArrayList2;
        type = AREA;
    } else if (_segmentedControl.selectedSegmentIndex == 2) {
        currentArray = localArrayList3;
        type = WEIGHT;
    } else if (_segmentedControl.selectedSegmentIndex == 3) {
        currentArray = localArrayList4;
        type = VOLUME;
    } else if (_segmentedControl.selectedSegmentIndex == 4) {
        currentArray = localArrayList5;
        type = TEMPERATURE;
    }
    leftIndex = 0;
    rightIndex = 0;
    [_pickerView reloadAllComponents];
    [_pickerView selectRow:0 inComponent:0 animated:NO];
    [_pickerView selectRow:0 inComponent:1 animated:NO];
}

- (void)initData {
    localArrayList1 = [NSMutableArray array];
    UnitInfo *localp1 = [[UnitInfo alloc] init];
    localp1.index = 100;
    localp1.text = @"米";
    localp1.value = 1.0;
    [localArrayList1 addObject:localp1];
    UnitInfo *localp2 = [[UnitInfo alloc] init];
    localp2.index = 101;
    localp2.text = @"厘米";
    localp2.value = 100.0;
    [localArrayList1 addObject:localp2];
    UnitInfo *localp3 = [[UnitInfo alloc] init];
    localp3.index = 102;
    localp3.text = @"分米";
    localp3.value = 10.0;
    [localArrayList1 addObject:localp3];
    UnitInfo *localp4 = [[UnitInfo alloc] init];
    localp4.index = 103;
    localp4.text = @"毫米";
    localp4.value = 1000.0;
    [localArrayList1 addObject:localp4];
    UnitInfo *localp5 = [[UnitInfo alloc] init];
    localp5.index = 104;
    localp5.text = @"千米";
    localp5.value = 0.001;
    [localArrayList1 addObject:localp5];
    UnitInfo *localp6 = [[UnitInfo alloc] init];
    localp6.index = 105;
    localp6.text = @"公里";
    localp6.value = 0.001;
    [localArrayList1 addObject:localp6];
    UnitInfo *localp7 = [[UnitInfo alloc] init];
    localp7.index = 106;
    localp7.text = @"里";
    localp7.value = 0.002;
    [localArrayList1 addObject:localp7];
    UnitInfo *localp8 = [[UnitInfo alloc] init];
    localp8.index = 107;
    localp8.text = @"英里";
    localp8.value = 0.000621;
    [localArrayList1 addObject:localp8];
    UnitInfo *localp9 = [[UnitInfo alloc] init];
    localp9.index = 108;
    localp9.text = @"海里";
    localp9.value = 0.0005399568034557236;
    [localArrayList1 addObject:localp9];
    UnitInfo *localp10 = [[UnitInfo alloc] init];
    localp10.index = 109;
    localp10.text = @"英尺";
    localp10.value = 3.281;
    [localArrayList1 addObject:localp10];
    UnitInfo *localp11 = [[UnitInfo alloc] init];
    localp11.index = 110;
    localp11.text = @"英寸";
    localp11.value = 39.370078740157481;
    [localArrayList1 addObject:localp10];
    UnitInfo *localp12 = [[UnitInfo alloc] init];
    localp12.index = 111;
    localp12.text = @"英寻";
    localp12.value = 0.5467468562055768;
    [localArrayList1 addObject:localp11];
    UnitInfo *localp13 = [[UnitInfo alloc] init];
    localp13.index= 112;
    localp13.text = @"码";
    localp13.value = 1.094;
    [localArrayList1 addObject:localp13];
    UnitInfo *localp14 = [[UnitInfo alloc] init];
    localp14.index= 113;
    localp14.text = @"杆";
    localp14.value = 0.01847182584762591;
    [localArrayList1 addObject:localp14];
//    map.put(Type.LENGTH, localArrayList1);
    
    
    localArrayList2 = [NSMutableArray array];
    UnitInfo *localp15 = [[UnitInfo alloc] init];
    localp15.index= 200;
    localp15.text = @"平方米";
    localp15.value = 1.0;
    [localArrayList2 addObject:localp15];
    UnitInfo *localp16 = [[UnitInfo alloc] init];
    localp16.index= 200;
    localp16.text = @"平方厘米";
    localp16.value = 10000.0;
    [localArrayList2 addObject:localp16];
    UnitInfo *localp17 = [[UnitInfo alloc] init];
    localp17.index= 200;
    localp17.text = @"平方公里";
    localp17.value = 1.0E-006;
    [localArrayList2 addObject:localp17];
    UnitInfo *localp18 = [[UnitInfo alloc] init];
    localp18.index= 200;
    localp18.text = @"平方英尺";
    localp18.value = 10.763999999999999;
    [localArrayList2 addObject:localp18];
    UnitInfo *localp19 = [[UnitInfo alloc] init];
    localp19.index= 200;
    localp19.text = @"平方英寸";
    localp19.value = 1549.9070055796653;
    [localArrayList2 addObject:localp19];
    UnitInfo *localp20 = [[UnitInfo alloc] init];
    localp20.index= 200;
    localp20.text = @"平方英里";
    localp20.value = 3.86E-007;
    [localArrayList2 addObject:localp20];
    UnitInfo *localp21 = [[UnitInfo alloc] init];
    localp21.index= 200;
    localp21.text = @"亩";
    localp21.value = 0.0015;
    [localArrayList2 addObject:localp21];
    UnitInfo *localp22 = [[UnitInfo alloc] init];
    localp22.index= 200;
    localp22.text = @"公顷";
    localp22.value = 0.0001;
    [localArrayList2 addObject:localp22];
//    map.put(Type.AREA, localArrayList2);
    
    
    localArrayList3 = [NSMutableArray array];
    UnitInfo *localp23 = [[UnitInfo alloc] init];
    localp23.index= 300;
    localp23.text = @"千克";
    localp23.value = 1.0;
    [localArrayList3 addObject:localp23];
    UnitInfo *localp24 = [[UnitInfo alloc] init];
    localp24.index= 300;
    localp24.text = @"克";
    localp24.value = 1000.0;
    [localArrayList3 addObject:localp24];
    UnitInfo *localp25 = [[UnitInfo alloc] init];
    localp25.index= 300;
    localp25.text = @"磅";
    localp25.value = 2.205;
    [localArrayList3 addObject:localp25];
    UnitInfo *localp26 = [[UnitInfo alloc] init];
    localp26.index= 300;
    localp26.text = @"盎司";
    localp26.value = 35.335689045936398;
    [localArrayList3 addObject:localp26];
    UnitInfo *localp27 = [[UnitInfo alloc] init];
    localp27.index= 300;
    localp27.text = @"克拉";
    localp27.value = 5000.0;
    [localArrayList3 addObject:localp27];
    UnitInfo *localp28 = [[UnitInfo alloc] init];
    localp28.index= 300;
    localp28.text = @"两";
    localp28.value = 20.0;
    [localArrayList3 addObject:localp28];
    UnitInfo *localp29 = [[UnitInfo alloc] init];
    localp29.index= 300;
    localp29.text = @"吨";
    localp29.value = 0.001;
    [localArrayList3 addObject:localp29];
    //    map.put(Type.WEIGHT, localArrayList3);
    
    
    localArrayList4 = [NSMutableArray array];
    UnitInfo *localp30 = [[UnitInfo alloc] init];
    localp30.index= 400;
    localp30.text = @"升";
    localp30.value = 1.0;
    [localArrayList4 addObject:localp30];
    UnitInfo *localp31 = [[UnitInfo alloc] init];
    localp31.index= 400;
    localp31.text = @"立方米";
    localp31.value = 0.001;
    [localArrayList4 addObject:localp31];
    UnitInfo *localp32 = [[UnitInfo alloc] init];
    localp32.index= 400;
    localp32.text = @"立方厘米";
    localp32.value = 1000.0;
    [localArrayList4 addObject:localp32];
    UnitInfo *localp33 = [[UnitInfo alloc] init];
    localp33.index= 400;
    localp33.text = @"加仑";
    localp33.value = 0.264;
    [localArrayList4 addObject:localp33];
    UnitInfo *localp34 = [[UnitInfo alloc] init];
    localp34.index= 400;
    localp34.text = @"品脱";
    localp34.value = 2.113;
    [localArrayList4 addObject:localp34];
    UnitInfo *localp35 = [[UnitInfo alloc] init];
    localp35.index= 400;
    localp35.text = @"夸脱";
    localp35.value = 1.056688;
    [localArrayList4 addObject:localp35];
//    map.put(Type.VOLUME, localArrayList4);
    
    
    localArrayList5 = [NSMutableArray array];
    UnitInfo *localp36 = [[UnitInfo alloc] init];
    localp36.index= 500;
    localp36.text = @"摄氏度";
    localp36.value = 1.0;
    [localArrayList5 addObject:localp36];
    UnitInfo *localp37 = [[UnitInfo alloc] init];
    localp37.index= 501;
    localp37.text = @"华氏度";
    localp37.value = 1.0;
    [localArrayList5 addObject:localp37];
//    map.put(Type.TEMPERATURE, localArrayList5);
 
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//确定picker的每个轮子的UnitInfo数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return [currentArray count];
    } else {//市的个数
        return [currentArray count];
    }
}

//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        UnitInfo *info = currentArray[row];
        return info.text;
    } else {
        UnitInfo *info = currentArray[row];
        return info.text;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        leftIndex = row;
        [self showResult];
    } else {
        rightIndex = row;
        [self showResult];
    }
}

- (void)showResult {
    NSString *leftdetail = _leftTextView.text;
    NSString *rightdetail = _rightTextView.text;
    double d1 = 0.0;
    double d2 = 0.0;
    if (leftdetail.length > 0) {
        d1 = [_leftTextView.text doubleValue];
    }
    if (rightdetail.length > 0) {
        d2 = [_rightTextView.text doubleValue];;
    }
    double leftvalue = 0.0;
    double rightvalue = 0.0;
    
    UnitInfo *leftInfo = currentArray[leftIndex];
    UnitInfo *rightInfo = currentArray[rightIndex];
    _centerLabel.text = [NSString stringWithFormat:@"%@ %@ %@", leftInfo.text, isRight ? @"->" : @"<-" ,rightInfo.text];
    leftvalue = leftInfo.value;
    rightvalue = rightInfo.value;
    if (!isRight) {
        if (type != TEMPERATURE) {
            [_leftTextView setText:[NSString stringWithFormat:@"%.5f", d2 * leftvalue / rightvalue]];
        } else {
            if (leftIndex == rightIndex) {
                [_leftTextView setText:[NSString stringWithFormat:@"%.5f", d2]];
            } else {
                if ([leftInfo.text isEqualToString:@"摄氏度"]) {
                    [_leftTextView setText:[NSString stringWithFormat:@"%.5f", 32.0 + 9.0 * d1 / 5.0]];
                } else {
                    [_leftTextView setText:[NSString stringWithFormat:@"%.5f", 5.0 * (d2 - 32.0) / 9.0]];
                }
            }
        }
    } else {
        if (type != TEMPERATURE) {
            [_rightTextView setText:[NSString stringWithFormat:@"%.5f", d1 * rightvalue / leftvalue]];
        } else {
            if (leftIndex == rightIndex) {
                [_rightTextView setText:[NSString stringWithFormat:@"%.5f", d1]];
            } else {
                if ([leftInfo.text isEqualToString:@"摄氏度"]) {
                    [_rightTextView setText:[NSString stringWithFormat:@"%.5f", 32.0 + 9.0 * d1 / 5.0]];
                } else {
                    [_rightTextView setText:[NSString stringWithFormat:@"%.5f", 5.0 * (d2 - 32.0) / 9.0]];
                }
            }
        }
    }
}

@end
