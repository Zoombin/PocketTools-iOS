//
//  ExchangeViewController.m
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ExchangeViewController.h"
#import "MoneyEntity.h"
#import "MoneyTableViewCell.h"

@interface ExchangeViewController ()

@end

@implementation ExchangeViewController  {
    NSMutableArray *infoArray;
    NSDictionary *localMoneys;
    NSString *inputValue;
    NSString *current;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    infoArray = [NSMutableArray array];
    inputValue = @"1";
    current = @"100";
    self.title = NSLocalizedString(@"汇率换算", nil);
    localMoneys = @{@"人民币" : @"cn,CNY,¥", @"英镑" : @"gb,GBP,£", @"港币" : @"hk,HKD,$", @"美元" : @"us,USD,$", @"瑞士法郎" : @"ch,CHF,Fr", @"新加坡元" : @"sg,SGD,$", @"瑞典克朗" : @"se,SEK,kr", @"丹麦克朗" : @"dk,DKK,kr" , @"挪威克朗" : @"no,NOK,kr", @"日元" : @"jp,JPY,¥", @"加拿大元" : @"ca,CAD,$", @"澳大利亚元" : @"au,AUD,$", @"澳门元" : @"mo,MOP,P", @"菲律宾比索" : @"ph,PHP,₱", @"泰国铢" : @"th,THB,฿", @"新西兰元" : @"nz,NZD,$", @"韩国元" : @"kr,KRW,₩", @"欧元" : @"eu,EUR,€"};
    [self loadExanchangeList];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(loadExanchangeList)];
    self.navigationItem.rightBarButtonItem = barButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadExanchangeList {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] exchangeList:^(NSDictionary *result, NSError *error) {
        if (!error) {
            [self hideHUD:YES];
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 200) {
                if ([resultInfo.result isKindOfClass:[NSArray class]]) {
                    NSLog(@"是数组");
                    if ([resultInfo.result count] > 0) {
                        [infoArray removeAllObjects];
                        inputValue = @"1";
                        current = @"100";
                        [self addChina];
                        NSArray *arr = (NSArray *)resultInfo.result;
                        for (NSString *dictKeys in [arr[0] allKeys]) {
                            MoneyEntity *entity = [[MoneyEntity alloc] initWithAttributes:arr[0][dictKeys]];
                            if ([[localMoneys allKeys] containsObject:entity.name]) {
                                NSArray *codesArray = [localMoneys[entity.name] componentsSeparatedByString:@","];
                                entity.cn = codesArray[0];
                                entity.code = codesArray[1];
                                entity.sign = codesArray[2];
                            }
                            [infoArray addObject:entity];
                        }
                    }
                }
                
            }
            [_tableView reloadData];
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)addChina {
    MoneyEntity *entity = [[MoneyEntity alloc] init];
    entity.name = @"人民币";
    entity.fBuyPri = @"100";
    entity.mBuyPri = @"100";
    entity.fSellPri = @"100";
    entity.mSellPri = @"100";
    entity.bankConversionPri = @"100";
    entity.cn = @"cn";
    entity.code = @"CNY";
    entity.sign = @"¥";
    [infoArray addObject:entity];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [infoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    MoneyTableViewCell *cell = (MoneyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MoneyTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
    }
    MoneyEntity *entity = infoArray[indexPath.row];
    cell.nameLabel.text = entity.name;
    cell.signLabel.text = entity.code;
    cell.flagImageView.image = [UIImage imageNamed:entity.cn];
    float f1 = [current floatValue] * ([inputValue floatValue] / [entity.mBuyPri floatValue]);
    cell.resultLabel.text = [NSString stringWithFormat:@"%.2f", f1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MoneyEntity *entity = infoArray[indexPath.row];
    current = entity.mBuyPri;
    _textField.placeholder = [NSString stringWithFormat:@"请输入%@金额", entity.name];
    
    [_textField becomeFirstResponder];
}

- (IBAction)sureButtonClicked:(id)sender {
    inputValue = _textField.text;
    [_tableView reloadData];
    [_textField resignFirstResponder];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _inputView.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    _inputView.hidden = NO;
    _textField.text = @"";
}

@end
