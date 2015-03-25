//
//  ScanViewController.m
//  PocketTools
//
//  Created by yc on 15-3-11.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "ScanViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ScanCityListViewController.h"
#import "GoodsInfo.h"
#import "ShopInfo.h"

@interface ScanViewController ()

@end

@implementation ScanViewController {
    NSMutableArray *companysArray;
    NSNumber *cityId;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    cityId = @(1);
    companysArray = [NSMutableArray array];
    [_tableView setTableHeaderView:_headerView];
    self.title = NSLocalizedString(@"条码比价", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"城市" style:UIBarButtonItemStylePlain target:self action:@selector(showSelectCity)];
    // Do any additional setup after loading the view from its nib.
    [self setupScaner];
}

- (void)showSelectCity {
    ScanCityListViewController *control = [ScanCityListViewController new];
    [BackButtonTool addBackButton:control];
    [self.navigationController pushViewController:control animated:YES];
}

-(void)setupScaner
{
    ZBarReaderView *readerView = [[ZBarReaderView alloc]init];
    [readerView.layer setBorderColor:[UIColor colorWithRed:200/255.0 green:255/255.0 blue:60/255.0 alpha:1.0].CGColor];
    readerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [readerView.layer setBorderWidth:.5];
    readerView.frame = CGRectMake(30, 64 + 10, self.view.frame.size.width - 60, 120);
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //扫描区域
    //    CGRect scanMaskRect = CGRectMake(60, CGRectGetMidY(readerView.frame) - 126, 200, 200);

    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR) {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    [self.view addSubview:readerView];
    [readerView start];
    
    [_tableView setFrame:CGRectMake(0, 10 + CGRectGetMaxY(readerView.frame), self.view.frame.size.width, self.view.frame.size.height - 160)];
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols) {
        NSString *text = symbol.data;
        NSLog(@"%@", text);
        if ([text length] > 0) {
            [_iconImageView setImage:image];
            [self searchGoodsWithNumber:text];
        }
    }
}

- (void)searchGoodsWithNumber:(NSString *)num {
    [companysArray removeAllObjects];
    [_tableView reloadData];
    [[ServiceRequest shared] goodsSearchWithNum:num
                                         cityId:cityId
                                      withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                GoodsInfo *goods = [[GoodsInfo alloc] initWithAttributes:resultInfo.result[@"summary"]];
                NSString *content = [NSString stringWithFormat:@"商品名称:%@\n价格:%@\n条形码:%@", goods.name, goods.interval, goods.barcode];
                [_contenTextView setText:content];
                if (resultInfo.result[@"shop"] != nil) {
                    if ([resultInfo.result[@"shop"] isKindOfClass:[NSArray class]]) {
                        [companysArray addObjectsFromArray:[ShopInfo initWithArray:resultInfo.result[@"shop"]]];
                        [_tableView reloadData];
                    }
                }
                if (![goods.imgurl isEqualToString:@""] && [goods.imgurl length] != 0) {
                    [_iconImageView setImageWithURL:[NSURL URLWithString:goods.imgurl]];
                }
            } else {
                [_contenTextView setText:@"商品名称:\n价格\n条形码\n"];
            }
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [companysArray count];
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
    ShopInfo *info = companysArray[indexPath.row];
    cell.textLabel.text = info.shopName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", info.price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)selectedCityId:(NSNumber *)cid {
    NSLog(@"%@", cid);
    cityId = cid;
}
@end
