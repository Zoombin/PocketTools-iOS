//
//  CarVioSearchViewController.m
//  PocketTools
//
//  Created by yc on 15-3-4.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CarVioSearchViewController.h"
#import "CarVioResultViewController.h"
#import "UserCarSearchInfo.h"
#import "ProvinceInfo.h"
#import "CityInfo.h"
#import "CarType.h"

@interface CarVioSearchViewController ()

@end

@implementation CarVioSearchViewController {
    NSMutableArray *allProvices;
    NSArray *allCitys;
    NSArray *carTypes;
    NSInteger currentIndex;
    NSInteger currentTypeIndex;
    NSInteger currentProviceIndex;
    NSArray *searchHistory;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"车辆违章查询", nil);
    allProvices = [NSMutableArray array];
    currentIndex = -1;
    currentTypeIndex = -1;
    currentProviceIndex = -1;
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setBackgroundColor:[UIColor colorWithRed:33/255.0 green:162/255.0 blue:232/255.0 alpha:1.0]];
    [searchButton setTitle:@"查询" forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(0, 0, 60, 30)];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
    
    [self loadCarTypes];
    [self loadAllCities];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getSearchHistory];
}

- (void)hidenAll {
    _carFrameLabel.hidden = YES;
    _carFrameTextField.hidden = YES;
    
    _engineLabel.hidden = YES;
    _engineTextField.hidden = YES;
    
    _registLabel.hidden = YES;
    _registTextField.hidden = YES;
}

- (void)searchButtonClicked {
    [_carNumTextField resignFirstResponder];
    if ([allProvices count] == 0 || carTypes == nil) {
        [self displayHUDTitle:nil message:@"城市信息或车辆类型尚未获取完毕!" duration:DELAY_TIMES];
        return;
    }
    CityInfo *cityInfo = allCitys[currentIndex];
    if ([_carNumTextField.text length] != 7) {
        [self displayHUDTitle:nil message:@"请填写正确的车牌号!" duration:DELAY_TIMES];
        return;
    }
    if (currentTypeIndex == -1 || currentIndex == -1) {
        [self displayHUDTitle:nil message:@"请完善信息!" duration:DELAY_TIMES];
        return;
    }
    
    BOOL hasFrame = NO;
    if ([cityInfo.classa integerValue] == 1) {
        hasFrame = YES;
        if ([cityInfo.classno integerValue] != 0) {
            if ([_carFrameTextField.text length] != [cityInfo.classno integerValue]) {
                [self displayHUDTitle:nil message:@"请填写正确的车架号!" duration:DELAY_TIMES];
                return;
            }
        }
    }
    
    BOOL hasEngine = NO;
    NSLog(@"%@", cityInfo.engine);
    if ([cityInfo.engine integerValue] == 1) {
        hasEngine = YES;
        if ([cityInfo.engineno integerValue] != 0) {
            if ([_engineTextField.text length] != [cityInfo.engineno integerValue]) {
                [self displayHUDTitle:nil message:@"请填写正确的发动机号!" duration:DELAY_TIMES];
                return;
            }
        }
    }
    
    BOOL hasRegist = NO;
    if ([cityInfo.regist integerValue] == 1) {
        hasRegist = YES;
        if ([cityInfo.registno integerValue] != 0) {
            if ([_registTextField.text length] != [cityInfo.registno integerValue]) {
                [self displayHUDTitle:nil message:@"请填写正确的注册证号!" duration:DELAY_TIMES];
                return;
            }
        }
    }
    NSMutableDictionary *searchInfo = [[NSMutableDictionary alloc] init];
    CarType *type = carTypes[currentTypeIndex];
    CarVioResultViewController *carVioResultViewCtrl = [CarVioResultViewController new];
    searchInfo[@"cityCode"] = cityInfo.cityCode;
    searchInfo[@"carNum"] = _carNumTextField.text;
    searchInfo[@"carType"] = type.carId;
    carVioResultViewCtrl.cityName = cityInfo.cityCode;
    carVioResultViewCtrl.carNum = _carNumTextField.text;
    carVioResultViewCtrl.carType = type.carId;
    if (hasFrame) {
        searchInfo[@"carFrameNum"] = _carFrameTextField.text;
        carVioResultViewCtrl.carFrameNum = _carFrameTextField.text;
    }
    if (hasEngine) {
        searchInfo[@"carEngineNum"] = _engineTextField.text;
        carVioResultViewCtrl.engineNum = _engineTextField.text;
    }
    if (hasRegist) {
        searchInfo[@"carRegist"] = _registTextField.text;
        carVioResultViewCtrl.registNum = _registTextField.text;
    }
    [[ServiceRequest shared] saveUserSearch:searchInfo];
    [BackButtonTool addBackButton:carVioResultViewCtrl];
    [self.navigationController pushViewController:carVioResultViewCtrl animated:YES];
}

- (void)getSearchHistory {
    searchHistory = [[ServiceRequest shared] getSearchHistory];
    [_tableView reloadData];
}

- (IBAction)selectCityButtonClicked:(id)sender {
    _pickerView.hidden = NO;
    if ([allProvices count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到城市信息" duration:DELAY_TIMES];
        return;
    }
    if (allCitys == nil) {
        ProvinceInfo *pinfo = allProvices[0];
        allCitys = pinfo.citys;
        currentIndex = 0;
        currentProviceIndex = 0;
        [_picker reloadAllComponents];
        [self showLabel];
    }
}

- (IBAction)sureButtonClicked:(id)sender {
    NSLog(@"%ld", currentIndex);
    _pickerView.hidden = YES;
    if (allCitys != nil) {
        CityInfo *info = allCitys[currentIndex];
        [_carNumTextField setText:info.abbr];
        [_cityButton setTitle:info.cityName forState:UIControlStateNormal];
    }
}

- (IBAction)seletTypeButtonClicked:(id)sender {
    if ([carTypes count] == 0) {
        [self displayHUDTitle:nil message:@"尚未获取到车辆类型" duration:DELAY_TIMES];
        return;
    }
    [self showActionSheet];
}

- (void)showActionSheet {
    [_carNumTextField resignFirstResponder];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setTitle:@"选择车辆类型"];
    for (int i = 0; i < [carTypes count]; i++) {
        CarType *type = carTypes[i];
        [actionSheet addButtonWithTitle:type.car];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    [actionSheet setCancelButtonIndex:[carTypes count]];
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.cancelButtonIndex == buttonIndex) {
        return;
    }
    currentTypeIndex = buttonIndex;
    CarType *type = carTypes[currentTypeIndex];
    [_carTypeButton setTitle:type.car forState:UIControlStateNormal];
}

- (void)loadCarTypes {
    [[ServiceRequest shared] loadCarTypesList:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                NSArray *typesArray = (NSArray *)resultInfo.result;
                carTypes = [CarType initWithArray:typesArray];
            }
        }
    }];
}

- (void)loadAllCities {
    [[ServiceRequest shared] loadAllSupportCities:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == SUCCESS_CODE) {
                for (int i = 0; i < [[resultInfo.result allKeys] count]; i++) {
                    NSDictionary *provices = resultInfo.result[[resultInfo.result allKeys][i]];
                    ProvinceInfo *info = [[ProvinceInfo alloc] initWithAttributes:provices];
                    [allProvices addObject:info];
                }
                [_picker reloadAllComponents];
            }
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return [allProvices count];
    } else {//市的个数
        return [allCitys count];
    }
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择省份名
        ProvinceInfo *info = allProvices[row];
        return info.province;
    } else {//选择市名
        CityInfo *info = allCitys[row];
        return info.cityName;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        ProvinceInfo *info = allProvices[row];
        currentProviceIndex = row;
        allCitys = info.citys;
        [_picker reloadAllComponents];
        [_picker selectRow:0 inComponent:1 animated:NO];
        currentIndex = 0;
        [self showLabel];
    } else {
        currentIndex = row;
        [self showLabel];
    }
}

- (void)showLabel {
    [self hidenAll];
    CityInfo *info = allCitys[currentIndex];
    NSLog(@"%ld", [info.classa integerValue]);
    NSLog(@"%ld", [info.engine integerValue]);
    NSLog(@"%ld", [info.regist integerValue]);
    if ([info.classa isEqualToString:@"1"]) {
        _carFrameTextField.hidden = NO;
        _carFrameLabel.hidden = NO;
        _carFrameTextField.placeholder = [info.classno integerValue] == 0 ? @"完整的车架号码" : [NSString stringWithFormat:@"车架号后%@位", info.classno];
    }
    if ([info.engine isEqualToString:@"1"]) {
        _engineTextField.hidden = NO;
        _engineLabel.hidden = NO;
        _engineTextField.placeholder = [info.engineno integerValue] == 0 ? @"完整的发动机号" : [NSString stringWithFormat:@"发动机号后%@位", info.engineno];
    }
    if ([info.regist isEqualToString:@"1"]) {
        _registTextField.hidden = NO;
        _registLabel.hidden = NO;
        _registTextField.placeholder = [info.registno integerValue] == 0 ? @"完整的登记证书号" : [NSString stringWithFormat:@"登记证书后%@位", info.registno];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *info = searchHistory[indexPath.row];
    cell.textLabel.text = info[@"carNum"];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *searchInfo = searchHistory[indexPath.row];
    CarVioResultViewController *carVioResultViewCtrl = [CarVioResultViewController new];
    carVioResultViewCtrl.cityName = searchInfo[@"cityCode"];
    carVioResultViewCtrl.carNum = searchInfo[@"carNum"];
    carVioResultViewCtrl.carType = searchInfo[@"carType"];
    carVioResultViewCtrl.carFrameNum = searchInfo[@"carFrameNum"];
    carVioResultViewCtrl.engineNum = searchInfo[@"carEngineNum"];
    carVioResultViewCtrl.registNum = searchInfo[@"carRegist"] ;
    [BackButtonTool addBackButton:carVioResultViewCtrl];
    [self.navigationController pushViewController:carVioResultViewCtrl animated:YES];

}

@end
