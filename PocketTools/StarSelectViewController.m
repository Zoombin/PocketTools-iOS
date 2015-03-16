//
//  StarSelectViewController.m
//  PocketTools
//
//  Created by yc on 15-3-16.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "StarSelectViewController.h"

@interface StarSelectViewController ()

@end

@implementation StarSelectViewController {
    NSArray *stars;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"选择星座", nil);
    // Do any additional setup after loading the view from its nib.
    stars = @[@"白羊座(3.21~4.19)", @"金牛座(4.20~5.20)", @"双子座(5.21~6.21)", @"巨蟹座(6.22~7.22)", @"狮子座(7.23~8.22)", @"处女座(8.23~9.22)", @"天秤座(9.23~10.23)", @"天蝎座(10.24~11.22)", @"射手座(11.23~12.21)", @"摩羯座(12.22~1.19)", @"水瓶座(1.20~2.18)", @"双鱼座2.19~3.20"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stars count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = stars[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
