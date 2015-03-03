//
//  TulingViewController.m
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "TulingViewController.h"
#import "RobotInfo.h"

@interface TulingViewController ()

@end

@implementation TulingViewController {
    NSMutableArray *infoArray;
    CLLocationManager *locationmanager;
    CLLocationCoordinate2D lastCoordinate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    locationmanager = [[CLLocationManager alloc] init];
    [locationmanager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
    [locationmanager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
    locationmanager.delegate = self;
    
    infoArray = [NSMutableArray array];
    self.title = NSLocalizedString(@"聊天机器人", nil);
    // Do any additional setup after loading the view from its nib.
    [self chatWithRobot:@"你好"];
    infoArray = [NSMutableArray array];
    [self getLat];
}

- (void)getLat
{
    [self startLocation];
}

- (void)startLocation
{
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        locationmanager.distanceFilter = 100;
        [locationmanager startUpdatingLocation];
    }
    else{
        UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alvertView show];
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    lastCoordinate = CLLocationCoordinate2DMake(newLocation.coordinate.latitude ,newLocation.coordinate.longitude);
    [manager stopUpdatingLocation];
    
}

- (void)chatWithRobot:(NSString *)content {
    [[ServiceRequest shared] chatWithRobot:content withBlock:^(NSDictionary *result, NSError *error) {
        ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
        if ([resultInfo.resultcode integerValue] == 0) {
            RobotInfo *info = [[RobotInfo alloc] init];
            info.text = resultInfo.result[@"text"];
            [infoArray addObject:info];
            [_tableView reloadData];
        }
    }];
}

- (IBAction)sendButto:(id)sender {
    [_textField resignFirstResponder];
    if ([_textField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"请输入内容!" duration:DELAY_TIMES];
        return;
    }
    RobotInfo *info = [[RobotInfo alloc] init];
    info.text = _textField.text;
    [infoArray addObject:info];
    [_tableView reloadData];
    
    [self chatWithRobot:_textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendButto:nil];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [infoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    RobotInfo *info = infoArray[indexPath.row];
    cell.textLabel.text = info.text;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
