//
//  StarViewController.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarViewController.h"
#import "StarCurrentInfo.h"
#import "StarWeekInfo.h"
#import "StarMonthInfo.h"
#import "StarYearInfo.h"

@interface StarViewController ()

@end

@implementation StarViewController {
    NSArray *stars;
    NSArray *types;
    NSArray *times;
    NSInteger currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"星座运势", nil);
    _firstButton.color = [UIColor colorWithRed:161/255.0 green:175/255.0 blue:53/255.0 alpha:1.0];
    _secondButton.color = [UIColor colorWithRed:234/255.0 green:91/255.0 blue:105/255.0 alpha:1.0];
    _thirdButton.color = [UIColor colorWithRed:238/255.0 green:184/255.0 blue:55/255.0 alpha:1.0];
    _fourthButton.color = [UIColor colorWithRed:109/255.0 green:165/255.0 blue:229/255.0 alpha:1.0];
    
    stars = @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座", @"水瓶座", @"双鱼座"];
    types = @[@"today",@"tomorrow",@"week",@"month",@"year"];
    times = @[@"3.21~4.19", @"4.20~5.20", @"5.21~6.21)", @"6.22~7.22", @"7.23~8.22", @"8.23~9.22", @"9.23~10.23", @"10.24~11.22", @"11.23~12.21", @"12.22~1.19", @"1.20~2.18", @"2.19~3.20"];
    currentIndex = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择星座" style:UIBarButtonItemStylePlain target:self action:@selector(selectStar)];
    [_segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
    
    CGFloat offSet_X = ([UIScreen mainScreen].bounds.size.width - (_firstButton.frame.size.width * 4)) / 5;
    CGFloat width = _firstButton.frame.size.width;
    CGFloat height = _firstButton.frame.size.height;
    NSArray *btns = @[_firstButton, _secondButton, _thirdButton, _fourthButton];
    for (int i = 0; i < [btns count]; i++) {
        UIButton *button = (UIButton *)btns[i];
        [button setFrame:CGRectMake((i + 1) * offSet_X + width * i, button.frame.origin.y, width, height)];
    }
    [_segmentedControl.layer setCornerRadius:8];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self valueChanged];
}

- (void)addLineSpace:(UITextView *)textView {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textView.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [textView.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [textView.text length])];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"FZKATJW--GB1-0" size:16] range:NSMakeRange(0, [textView.text length])];
    textView.attributedText = attributedString;
}

- (void)valueChanged {
//    今日 明日 本周 本月 今年
    _firstButton.hidden = YES;
    _secondButton.hidden = YES;
    _thirdButton.hidden = YES;
    _fourthButton.hidden = YES;
    
    _contentTextView.text = @"";
    _describeLabel.text = @"";
    _dayLabel1.text = @"";
    _dayLabel2.text = @"";
    _dayLabel3.text = @"";
    _dayContentTextView.text = @"";
    _firstButton.per = 0;
    _firstButton.text = @"健康";
    [_firstButton reDraw];
    
    _secondButton.per = 0;
    _secondButton.text = @"爱情";
    [_secondButton reDraw];
    
    _thirdButton.per = 0;
    _thirdButton.text = @"财运";
    [_thirdButton reDraw];
    
    _fourthButton.per = 0;
    _fourthButton.text = @"工作";
    [_fourthButton reDraw];
    [self showInfo];
}

- (void)showInfo {
    NSString *type = types[_segmentedControl.selectedSegmentIndex];
    [self displayHUD:@"加载中..."];
    NSString *starName = [[ServiceRequest shared] getStarName];
    currentIndex = [stars indexOfObject:starName];
    
    [_iconButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%ld.png", currentIndex]] forState:UIControlStateNormal];
    [_iconButton setTitle:starName forState:UIControlStateNormal];
    [_timeLabel setText:times[currentIndex]];

    [[ServiceRequest shared] searchStarLuckByName:starName type:type withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                if (_segmentedControl.selectedSegmentIndex == 0 || _segmentedControl.selectedSegmentIndex == 1) {
                    _firstButton.hidden = NO;
                    _secondButton.hidden = NO;
                    _thirdButton.hidden = NO;
                    _fourthButton.hidden = NO;
                    StarCurrentInfo *cInfo = [[StarCurrentInfo alloc] initWithAttributes:result];
                    [self showInfoWithCurrent:cInfo];
                } else if (_segmentedControl.selectedSegmentIndex == 2) {
                    StarWeekInfo *nInfo = [[StarWeekInfo alloc] initWithAttributes:result];
                    [self showInfoWithWeek:nInfo];
                } else if (_segmentedControl.selectedSegmentIndex == 3) {
                    StarMonthInfo *mInfo = [[StarMonthInfo alloc] initWithAttributes:result];
                    [self showInfoWithMonth:mInfo];
                } else if (_segmentedControl.selectedSegmentIndex == 4) {
                    StarYearInfo *yInfo = [[StarYearInfo alloc] initWithAttributes:result];
                    [self showInfoWithYear:yInfo];
                }
                [self addLineSpace:_contentTextView];
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)showInfoWithCurrent:(StarCurrentInfo *)info {
    NSLog(@"%@", info);
    _dayLabel1.text = [NSString stringWithFormat:@"综合指数:%@ 速配星座:%@", info.all, info.QFriend];
    _dayLabel2.text = [NSString stringWithFormat:@"幸运数字:%@ 幸运颜色:%@", info.number, info.color];
    _dayLabel3.text = [NSString stringWithFormat:@"健康:%@ 爱情:%@ 财运:%@ 工作:%@", info.health, info.love, info.money, info.work];
    NSString *health = [info.health stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *love = [info.love stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *money = [info.money stringByReplacingOccurrencesOfString:@"%" withString:@""];
    NSString *work = [info.work stringByReplacingOccurrencesOfString:@"%" withString:@""];
    _firstButton.per = [health floatValue] / 100;
    _firstButton.text = @"健康";
    [_firstButton reDraw];
    
    _secondButton.per = [love floatValue] / 100;
    _secondButton.text = @"爱情";
    [_secondButton reDraw];
    
    _thirdButton.per = [money floatValue] / 100;
    _thirdButton.text = @"财运";
    [_thirdButton reDraw];
    
    _fourthButton.per = [work floatValue] / 100;
    _fourthButton.text = @"工作";
    [_fourthButton reDraw];
    _dayContentTextView.text = info.summary;
    [self addLineSpace:_dayContentTextView];
    _contentTextView.hidden = YES;
}

- (void)showInfoWithWeek:(StarWeekInfo *)info {
    _describeLabel.text = [NSString stringWithFormat:@"第%@周运势", info.weekth];
    NSString *content = [NSString stringWithFormat:@"%@\n\n%@\n\n%@\n\n%@", info.job, info.love, info.health, info.money];
    _contentTextView.text = content;
    _contentTextView.hidden = NO;
}

- (void)showInfoWithMonth:(StarMonthInfo *)info {
    _describeLabel.text = [NSString stringWithFormat:@"%@运势", info.date];
    NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@\n", info.all, info.work, info.love, info.health, info.money];
    _contentTextView.text = content;
    _contentTextView.hidden = NO;
}

- (void)showInfoWithYear:(StarYearInfo *)info {
    _describeLabel.text = [NSString stringWithFormat:@"%@运势", info.date];
    NSMutableString *content = [@"" mutableCopy];
    if ([info.career isKindOfClass:[NSArray class]]) {
        if ([info.career count] > 0) {
            [content appendFormat:@"%@\n", info.career[0]];
        }
    }
    if ([info.love isKindOfClass:[NSArray class]]) {
        if ([info.love count] > 0) {
            [content appendFormat:@"\n%@\n", info.love[0]];
        }
    }
    if ([info.health isKindOfClass:[NSArray class]]) {
        if ([info.health count] > 0) {
            [content appendFormat:@"\n%@\n", info.health[0]];
        }
    }
    if ([info.finance isKindOfClass:[NSArray class]]) {
        if ([info.finance count] > 0) {
            [content appendFormat:@"\n%@\n", info.finance[0]];
        }
    }
    _contentTextView.text = content;
}

- (void)selectStar {
    StarSelectViewController *viewCtrl = [StarSelectViewController new];
    viewCtrl.delegate = self;
    [BackButtonTool addBackButton:viewCtrl];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)selectStarAtIndex:(NSInteger)index {
    currentIndex = index;
    [[ServiceRequest shared] saveStarName:stars[currentIndex]];
    [_iconButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%ld.png", index]] forState:UIControlStateNormal];
    [_iconButton setTitle:stars[index] forState:UIControlStateNormal];
    [_timeLabel setText:times[index]];
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
