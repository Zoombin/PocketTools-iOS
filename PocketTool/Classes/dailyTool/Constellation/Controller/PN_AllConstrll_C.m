//
//  PN_AllConstrll_C.m
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_AllConstrll_C.h"

@interface PN_AllConstrll_C ()
@property (nonatomic,strong) NSArray *arr;
@end

@implementation PN_AllConstrll_C

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //标题
    self.title = @"选择星座";
    
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.arr =@[@"白羊座(3.21-4.19)",@"金牛座(4.20-5.20)",@"双子座(5.21-6.21)",@"巨蟹座(6.22-7.22)",@"狮子座(7.23-8.22)",@"处女座(8.23-9.22)",@"天秤座(9.23-10.23)",@"天蝎座(10.24-11.22)",@"射手座(11.23-12.21)",@"摩羯座(12.22-1.19)",@"水瓶座(1.20-2.18)",@"双鱼座(2.19-3.20)"];
    
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    NSString *text = self.arr[indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}
//点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
