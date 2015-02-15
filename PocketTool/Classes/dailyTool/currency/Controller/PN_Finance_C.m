//
//  PN_Finance_C.m
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Finance_C.h"
#import "PN_Finance_M.h"
#import "PN_Exchange_M.h"
@interface PN_Finance_C ()
@property (nonatomic,strong) NSArray *dataArr;
@property (nonatomic,strong) NSArray *data1;
@property (nonatomic,strong) NSArray *data2;
//
@property (nonatomic,weak) UISegmentedControl *segment;
@end

@implementation PN_Finance_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //绑定ID
    JUHE;
    
    //创建切换按钮
   UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"人民币牌价",@"外汇汇率"]];
    //默认选中
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:(UIControlEventValueChanged)];
    self.navigationItem.titleView = segment;
    self.segment = segment;
    
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    //请求数据
    [self getInfo];
}
//请求数据
- (void)getInfo
{
   //人民币牌价
    [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:@"http://web.juhe.cn:8080/finance/exchange/rmbquot" APIID:@"23" Parameters:nil Method:@"GET" Success:^(id responseObject) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"result"]) {
           NSEnumerator *f = [dict objectEnumerator];
            NSDictionary *dic = [[NSDictionary alloc]init];
            while (dic =[f nextObject]) {
              PN_Finance_M *finance =  [PN_Finance_M objectWithKeyValues:dic];
                [temp addObject:finance];
            }
        }
       self.data1 = temp;
        //默认点击0下标的按钮
        [self segmentClick:self.segment];
    } Failure:^(NSError *error) {
        
    }];
    
    //外汇牌价
    [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:@"http://web.juhe.cn:8080/finance/exchange/frate" APIID:@"23" Parameters:nil Method:@"GET" Success:^(id responseObject) {
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"result"]) {
            NSEnumerator *f = [dict objectEnumerator];
            NSDictionary *dic = [[NSDictionary alloc]init];
            while (dic =[f nextObject]) {
                PN_Exchange_M *Exchange =  [PN_Exchange_M objectWithKeyValues:dic];
                [temp addObject:Exchange];
            }
        }
        self.data2 = temp;
    } Failure:^(NSError *error) {
        
    }];
}

//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)segmentClick:(UISegmentedControl *)segement
{
    if (segement.selectedSegmentIndex == 0) {
        self.dataArr = self.data1;
    }else if (segement.selectedSegmentIndex == 1){
        self.dataArr = self.data2;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:nil];
    if(cell==nil){
        cell =[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:nil];
    }
    PN_Finance_M *finance = [[PN_Finance_M alloc]init];
    PN_Exchange_M *exchange = [[PN_Exchange_M alloc]init];
    if (self.segment.selectedSegmentIndex==0) {
      finance = self.dataArr[indexPath.row];
        cell.textLabel.text = finance.name;
        cell.detailTextLabel.text = finance.bankConversionPri;
    } else if(self.segment.selectedSegmentIndex ==1){
        exchange = self.dataArr[indexPath.row];
        cell.textLabel.text = exchange.currency;
        cell.detailTextLabel.text = exchange.closePri;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
