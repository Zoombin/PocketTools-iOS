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
    NSInteger currentIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"星座运势", nil);
    stars = @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座", @"射手座", @"摩羯座", @"水瓶座", @"双鱼座"];
    types = @[@"today",@"tomorrow",@"week",@"month",@"year"];
    currentIndex = 11;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择星座" style:UIBarButtonItemStylePlain target:self action:@selector(selectStar)];
    [_segmentedControl addTarget:self action:@selector(valueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self valueChanged];
}

- (void)addLineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_contentTextView.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_contentTextView.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [_contentTextView.text length])];
    _contentTextView.attributedText = attributedString;
}

- (void)valueChanged {
//    今日 明日 本周 本月 今年
    _contentTextView.text = @"";
    _describeLabel.text = @"";
    _dayLabel1.text = @"";
    _dayLabel2.text = @"";
    _dayLabel3.text = @"";
    _dayContentTextView.text = @"";
    [self showInfo];
}

- (void)showInfo {
    NSString *type = types[_segmentedControl.selectedSegmentIndex];
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] searchStarLuckByName:stars[currentIndex] type:type withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                [self hideHUD:YES];
                if (_segmentedControl.selectedSegmentIndex == 0 || _segmentedControl.selectedSegmentIndex == 1) {
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
                [self addLineSpace];
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
    _dayContentTextView.text = info.summary;
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
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)selectStarAtIndex:(NSInteger)index {
    currentIndex = index;
    [_iconButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"star_%ld.png", index]] forState:UIControlStateNormal];
    [_iconButton setTitle:stars[index] forState:UIControlStateNormal];
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
