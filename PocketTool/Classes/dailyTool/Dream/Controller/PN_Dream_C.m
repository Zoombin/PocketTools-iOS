//
//  PN_Dream_C.m
//  PocketTool
//
//  Created by Mac on 15-2-9.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Dream_C.h"
#import "PN_Dream_M.h"
#import "MJExtension.h"
@interface PN_Dream_C ()
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) UIImageView *backImage;
@end

@implementation PN_Dream_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //绑定ID
    JUHE;
    
//    //设置背景
//    self.backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
//    self.backImage.image = [UIImage imageNamed:@"bg2.jpg"];
//    [self.view addSubview:self.backImage];
    
    //移除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    //标题
    self.title = @"周公解梦";
    
    //请求数据
    [self search];
}

//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

//查询点击事件
- (void)search
{
    [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:@"http://v.juhe.cn/dream/category" APIID:@"64" Parameters:nil Method:@"GET" Success:^(id responseObject){
      self.array = [PN_Dream_M objectArrayWithKeyValuesArray:responseObject[@"result"]];
    
       [self.tableView reloadData];
    } Failure:^(NSError *error) {
       // [MBProgressHUD showError:@"请求失败"];
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"ID";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
      cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID];
    }
    PN_Dream_M *dream = self.array[indexPath.row];
    cell.textLabel.text = dream.name;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
