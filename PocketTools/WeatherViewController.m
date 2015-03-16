//
//  WeatherViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "WeatherViewController.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController {
    NSString *cityName;
    NSArray *backgroundImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    backgroundImages = @[@"bg_sunny", @"bg_cloudy", @"bg_normal", @"bg_rain", @""];
    self.title = NSLocalizedString(@"天气预报", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(getCityList)];
    
    [self searchCityByName:@"苏州"];
    // Do any additional setup after loading the view from its nib.
}

- (void)getCityList {
    WeatherCitiesViewController *viewCtrl = [WeatherCitiesViewController new];
    viewCtrl.delegate = self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)searchCityByName:(NSString *)name {
    [[ServiceRequest shared] searchAirByCity:name withBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"%@", result);
    }];
}

- (void)selectCityName:(NSString *)cityName {
    self.title = cityName;
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
