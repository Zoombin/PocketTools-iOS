//
//  CalculatorViewController.m
//  PocketTools
//
//  Created by yc on 15-2-28.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController {
    CGFloat caluculatorHeight;
    CGFloat caluculatorWidth;
    CGFloat numHeight;
    CGFloat numWidth;
    NSArray *typesArray;
    NSArray *numsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"科学计算器";
    typesArray = @[@"log", @"ln", @"n√x", @"X^n", @"%", @"sin", @"cos", @"tan"];
    numsArray = @[@"C", @"(", @")", @"<-", @"7", @"8", @"9", @"X", @"4", @"5", @"6", @"÷", @"1", @"2", @"3", @"-", @"0", @".", @"=", @"+"];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    caluculatorHeight = (screenHeight - CGRectGetMaxY(_preLabel.frame)) / 12;
    numHeight = (screenHeight - CGRectGetMaxY(_preLabel.frame)) / 6;
    caluculatorWidth = screenWidth / 4;
    numWidth = screenWidth / 4;
    
    [_resultLabel setAdjustsFontSizeToFitWidth:YES];
    
    [self initCalculatorTypeButtons];
    [self initNumButtons];
}

- (void)initCalculatorTypeButtons {
    int line = 1;
    int index = 0;
    for (int i = 0; i < [typesArray count]; i++) {
        if (i != 0 && i % 4 == 0) {
            index = 0;
            line ++;
        }
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeButton setBackgroundColor:[UIColor lightGrayColor]];
        [typeButton setTitle:typesArray[i] forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [typeButton setFrame:CGRectMake(index * caluculatorWidth, CGRectGetMaxY(_preLabel.frame) + ((line - 1) * caluculatorHeight), caluculatorWidth, caluculatorHeight)];
        [self.view addSubview:typeButton];
        index++;
    }
}

- (void)initNumButtons {
    int line = 1;
    int index = 0;
    for (int i = 0; i < [numsArray count]; i++) {
        if (i != 0 && i % 4 == 0) {
            index = 0;
            line ++;
        }
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [typeButton setBackgroundColor:[UIColor lightGrayColor]];
        [typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [typeButton setTitle:numsArray[i] forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [typeButton setFrame:CGRectMake(index * numWidth, caluculatorHeight * 2 + CGRectGetMaxY(_preLabel.frame) + ((line - 1) * numHeight), numWidth, numHeight)];
        [self.view addSubview:typeButton];
        index++;
    }
}

- (void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSString *str = btn.titleLabel.text;
    if ([_resultLabel.text isEqualToString:@"Error"]) {
        _resultLabel.text = @"";
    }
    if ([str isEqualToString:@"C"]) {
        //清空
        _resultLabel.text = @"";
    } else if ([str isEqualToString:@"<-"]) {
        //回退
        if ([_resultLabel.text length] > 1) {
            NSString *afterString = [_resultLabel.text substringToIndex:_resultLabel.text.length - 1];
            _resultLabel.text = afterString;
        } else {
            _resultLabel.text = @"";
        }
    } else if ([str isEqualToString:@"="]) {
        [self calculatorResult];
    } else {
        str = [_resultLabel.text stringByAppendingString:btn.titleLabel.text];
        _resultLabel.text = str;
    }
}

- (void)calculatorResult {
    NSString *str = _resultLabel.text;
    if ([str length] == 0) {
        return;
    }
    float result;
    BOOL hasTypeBefore = NO;
    for (int i = 0; i < [str length]; i++) {
        NSString *c = [NSString stringWithFormat:@"%c", [str characterAtIndex:i]];
        if ([c isEqualToString:@"+"]) {
            if (hasTypeBefore) {
                [self showError];
                return;
            } else {
                hasTypeBefore = YES;
            }
        } else if ([c isEqualToString:@"-"]) {
            if (hasTypeBefore) {
                [self showError];
                return;
            } else {
                hasTypeBefore = YES;
            }
        } else if ([c isEqualToString:@"X"]) {
            if (hasTypeBefore) {
                [self showError];
                return;
            } else {
                hasTypeBefore = YES;
            }
        } else if ([c isEqualToString:@"÷"]) {
            if (hasTypeBefore) {
                [self showError];
                return;
            } else {
                hasTypeBefore = YES;
            }
        }
    }
}

- (void)showError {
    _resultLabel.text = @"Error";
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
