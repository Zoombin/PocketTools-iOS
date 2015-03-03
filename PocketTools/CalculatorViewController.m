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
    
    NSMutableArray *_resultArray;
    NSString *_tempStr;
    CalculatorTools *calculatorTools;
    NSString *_lastAnswer;
    NSString *_passString;
    //计算次数标识符
    int countFlat;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    calculatorTools = [[CalculatorTools alloc]init];
    _resultArray = [NSMutableArray array];
    _resultText.text = @"";
    _preLabel.text = @"";
    _lastAnswer = @"";
    _tempStr = [NSString string];
    _passString = [NSString string];
    
    self.title = @"科学计算器";
    typesArray = @[@"log", @"ln", @"ⁿ√x", @"^", @"%", @"sin", @"cos", @"tan"];
    numsArray = @[@"C", @"(", @")", @"DEL", @"7", @"8", @"9", @"x", @"4", @"5", @"6", @"÷", @"1", @"2", @"3", @"-", @"0", @".", @"=", @"+"];
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    caluculatorHeight = (screenHeight - CGRectGetMaxY(_preLabel.frame)) / 12;
    numHeight = (screenHeight - CGRectGetMaxY(_preLabel.frame)) / 6;
    caluculatorWidth = screenWidth / 4;
    numWidth = screenWidth / 4;
    
    [_resultText setAdjustsFontSizeToFitWidth:YES];
    
    [self initCalculatorTypeButtons];
    [self initNumButtons];
}

#pragma - mark Button Actions
- (void)tapAction:(UIButton *)sender {
    long int tag = sender.tag;
    switch (tag) {
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case kDot:
        case kRightBracket:
        case kLeftBracket:
        case kDevide:
        case kSub:
        case kPlus:
        case kMultiply:
        case kPower:
        case kRadical:
        case kSin:
        case kCos:
        case kTan:
        case kLn:
        case kLog:
        case kMod:
        {
            //若为第一次运算
            if (countFlat == 0) {
                if (tag == kRadical) {
                    //若为根号,则将按钮的ⁿ√x显示成√，主要是为了显示效果
                    _resultText.text = [_tempStr stringByAppendingString:@"√"];
                }else{
                    _resultText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                }
            }
            //不是第一次运算
            else{
                if (tag == kPower || tag == kRightBracket || tag == kLeftBracket ||tag == kDevide ||tag == kSub ||tag == kPlus || tag== kMultiply || tag == kRadical || tag == kMod) {
                    if (![_resultText.text isEqualToString:@"error"]) {
                        //判断是否为根号，若为根号，把ⁿ√x换成√，主要是为了改善显示，就是所谓的用户体验
                        if (tag == kRadical) {
                            _resultText.text = [_tempStr stringByAppendingString:@"√"];
                        }else{
                            _resultText.text = [_resultText.text stringByAppendingString:sender.titleLabel.text];
                        }
                    }else{
                        if (tag == kRadical) {
                            _resultText.text = [_tempStr stringByAppendingString:@"√"];
                        }else{
                            _resultText.text = [@"0" stringByAppendingString:sender.titleLabel.text];
                        }
                        
                    }
                }else{
                    _resultText.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                }
            }
            _tempStr = _resultText.text;
            
        }
            break;
        case kClear:
            [self clearAll];
            break;
        case kDel:
            [self deleteBack];
            break;
        case kEqual:
        {
            if (![_tempStr isEqualToString:@""]) {
                _passString = [self replaceInputStrWithPassStr:_tempStr];
                _preLabel.text = [_tempStr stringByAppendingString:sender.titleLabel.text];
                _lastAnswer = [_resultArray lastObject];
                if ([_lastAnswer isEqualToString:@"error"]||countFlat == 0 ||[_lastAnswer isEqualToString:@""]) {
                    _tempStr = [calculatorTools calculatingWithString:_passString andAnswerString:@"0"];
                }else{
                    _tempStr = [calculatorTools calculatingWithString:_passString andAnswerString:_lastAnswer];
                }
                
                _resultText.text = _tempStr;
                _lastAnswer = _tempStr;
                if (![_lastAnswer isEqualToString:@"error"]) {
                    [_resultArray addObject:_lastAnswer];
                }
                //每一次求完之后，将_temp清空
                _tempStr = [NSString string];
                //执行过一次计算后，使flag置1
                countFlat = 1;
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma - mark Ultity Methods
- (NSString *)replaceInputStrWithPassStr:(NSString *)inputStr{
    NSString *tempString = inputStr;
    //将字符串长度大于1的运算符换成单字符，以便后面的操作
    if (!([tempString rangeOfString:@"sin"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"sin" withString:@"s"];
    }
    if (!([tempString rangeOfString:@"cos"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"cos" withString:@"c"];
    }
    if (!([tempString rangeOfString:@"tan"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"tan" withString:@"t"];
    }
    if (!([tempString rangeOfString:@"log"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"log" withString:@"l"];
    }
    if (!([tempString rangeOfString:@"ln"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"ln" withString:@"e"];
    }
    //替换根号符，由于除号编码超过了unichar，所以换成字母
    if (!([tempString rangeOfString:@"√"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"√" withString:@"g"];
    }
    //替换除号，由于除号编码超过了unichar，所以换成字母
    if (!([tempString rangeOfString:@"÷"].location == NSNotFound)) {
        tempString = [tempString stringByReplacingOccurrencesOfString:@"÷" withString:@"d"];
    }
    //将Ans换成上一次答案，若上一次出错或者为空，则使其置0
    if (!([tempString rangeOfString:@"Ans"].location == NSNotFound)) {
        if ([_lastAnswer isEqualToString:@"error"]||[_lastAnswer isEqualToString:@""]) {
            tempString = [tempString stringByReplacingOccurrencesOfString:@"Ans" withString:@"0"];
        }else
            tempString = [tempString stringByReplacingOccurrencesOfString:@"Ans" withString:[NSString stringWithFormat:@"%g",[_lastAnswer doubleValue]]];
    }
    return tempString;
}

- (void)clearAll
{
    _resultText.text = @"";
    _preLabel.text = @"";
    _resultArray = nil;
    _tempStr = @"";
    _passString = @"";
    countFlat = 0;
    _lastAnswer = @"";
}

- (void)deleteBack{
    if (![_resultText.text isEqual:@""]) {
        if (([_resultText.text length] == 1)||[_resultText.text isEqualToString: @"error"]) {
            _resultText.text = @"";
        }else{
            _resultText.text = [_resultText.text substringToIndex:_resultText.text.length -1];
        }
        _tempStr = _resultText.text;
    }else{
        return;
    }
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
        [typeButton setBackgroundColor:[UIColor colorWithRed:82/255.0 green:106/255.0 blue:120/255.0 alpha:1.0]];
        [typeButton setTitle:typesArray[i] forState:UIControlStateNormal];
        [typeButton.layer setBorderColor:[UIColor colorWithRed:62/255.0 green:91/255.0 blue:107/255.0 alpha:1.0].CGColor];
        [typeButton.layer setBorderWidth:.5];
        [self setTagWithBtn:typeButton];
        [typeButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
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
        [typeButton setBackgroundColor:[UIColor colorWithRed:103/255.0 green:124/255.0 blue:136/255.0 alpha:1.0]];
        [typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [typeButton setTitle:numsArray[i] forState:UIControlStateNormal];
        [self setTagWithBtn:typeButton];
        [typeButton.layer setBorderColor:[UIColor colorWithRed:62/255.0 green:91/255.0 blue:107/255.0 alpha:1.0].CGColor];
        [typeButton.layer setBorderWidth:.5];
        [typeButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [typeButton setFrame:CGRectMake(index * numWidth, caluculatorHeight * 2 + CGRectGetMaxY(_preLabel.frame) + ((line - 1) * numHeight), numWidth, numHeight)];
        [self.view addSubview:typeButton];
        index++;
    }
}

- (void)setTagWithBtn:(UIButton *)button {
    NSString *title = button.titleLabel.text;
    NSArray *arr = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"C", @"DEL", @"÷", @"x", @"-", @"+", @"=", @")", @"(", @".", @"^", @"sina", @"cos", @"tan", @"log", @"ln", @"ⁿ√x", @"%"];
    for (int i = 0; i < [arr count]; i++) {
        if ([arr[i] isEqualToString:title]) {
            button.tag = i;
        }
    }
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
