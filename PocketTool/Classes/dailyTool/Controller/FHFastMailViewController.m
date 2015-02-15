//
//  FHFastMailViewController.m
//  FotoableHelp
//
//  Created by 术东 on 15-2-9.
//  Copyright (c) 2015年 fotoable. All rights reserved.
//

#import "FHFastMailViewController.h"
#import "FHFatMailDetailController.h"
@interface FHFastMailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIButton *fastOldbutton;
/**
 *  快递类型数组
 */
@property (nonatomic,strong) NSArray *fastTypeArray;
/**
 *  查询快递返回数据字典
 */
@property (nonatomic,strong) NSDictionary *dataDict;
@property (nonatomic,strong) UIView *fastView;
@property (nonatomic,copy)   NSString *noString;
@property (nonatomic,copy)   NSString *comString;
@property (nonatomic,weak)   UITextField *searchField;
@property (nonatomic,strong) UITableView *historyView;
@property (nonatomic,strong) NSMutableArray *hisArray;
@property (nonatomic,strong) NSArray *historyData;

@end

@implementation FHFastMailViewController


-(UIView *)fastView{
    if (_fastView ==nil) {
        _fastView = [[UIView alloc]initWithFrame:CGRectMake(0, 84, mainW, 60)];
    }
    return _fastView;
}

-(NSMutableArray *)hisArray
{
    if (_hisArray == nil) {
        _hisArray = [NSMutableArray array];
    }
    return _hisArray;
}


-(void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
  [self getHistoryDatas];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    JUHE;
    self.view.backgroundColor = [UIColor orangeColor];
    /**1.设置导航栏*/
    self.title = @"快递查询";
    
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    /** 发送请求*/
    [self requestData];
    

}

-(void)getHistoryDatas
{
    //取文件
    NSString *pathFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"];
    self.historyData = [NSArray arrayWithContentsOfFile:pathFile];

    [self.historyView reloadData];

}

-(void)requestData
{
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/exp/com" APIID:@"43" Parameters:nil Method:@"GET" Success:^(id responseObject) {
        self.fastTypeArray = responseObject[@"result"];
        [self createFastMailButtonsWithArray:self.fastTypeArray];
        
    } Failure:^(NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
}


/**
 *  创建快递button
 */
-(void)createFastMailButtonsWithArray:(NSArray *)array
{
    [self.view addSubview:self.fastView ];
    
    CGFloat btnW = mainW/4;
    CGFloat padding = 20;
    CGFloat btnH = 25;
    UIButton *fastButton=nil;
    CGFloat tempY =0;
    for (int i = 0; i<array.count; i++) {
        
        int row = i/2;//多少行
        int col = i%2;//多少列
        float btnX = row * (btnW); //X的值根据行号决定
        float btnY = col * (btnH); //Y的值根据列号决定
        fastButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        fastButton.frame = CGRectMake(btnX +10, btnY, btnW - 30, btnH );
        fastButton.tag = i +1031;
        [fastButton setTitle:array[i][@"com"] forState:(UIControlStateNormal)];
        [fastButton setBackgroundImage:[UIImage imageNamed:@"btn_textbutton"] forState:(UIControlStateSelected)];
        [self.fastView addSubview:fastButton];
        [fastButton addTarget:self action:@selector(fastButtonClick:) forControlEvents:(UIControlEventTouchDown)];
        
        if (i==0) {
            [self fastButtonClick:fastButton];
        }
        if (i == array.count-1) {
            tempY = btnY +btnH;
        }
    }
    
    //创建查询输入框和查询按钮
    CGFloat W =  mainW -80;
    CGFloat H = 30;
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.fastView.frame) ,W, H)];
    [searchField setBackground:[UIImage imageNamed:@"gr_dash_lightgrey"]];
    searchField.placeholder = @"输入运单号";
    self.searchField = searchField;
    [self.view addSubview:self.searchField];
    
    UIButton *searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    searchBtn.frame = CGRectMake(mainW - 60, CGRectGetMaxY(self.fastView.frame), 50, H) ;
    [searchBtn setTitle:@"查询" forState:(UIControlStateNormal)];
    [searchBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"gr_dash_white"] forState:(UIControlStateNormal)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"gr_dash_lightgrey"] forState:(UIControlStateSelected)];
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:searchBtn];
    
    //分割线
    UIView *lineView =[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBtn.frame) +padding, mainW, 1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineView];
    
    UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBtn.frame) +padding *2, mainW, padding)];
   
    headLabel.textColor = [UIColor whiteColor];
    headLabel.text = @"   最近查询";
    headLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.view addSubview:headLabel];
    
    CGFloat viewH = CGRectGetMaxY(searchBtn.frame) +padding ;
    
    self.historyView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBtn.frame) +padding *3 , mainW, mainH - viewH) style:(UITableViewStylePlain)];
    self.historyView.backgroundColor = [UIColor orangeColor];
    self.historyView.delegate = self;
    self.historyView.dataSource = self;
    self.historyView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.historyView];
   
    /**从本地取历史数据*/
    [self getHistoryDatas];
}

/**
 *  快递按钮点击
 */
-(void)fastButtonClick:(UIButton *)btn
{
    int tag = (int)btn.tag - 1031;
    
    //记录当前的快递no和com
    self.noString = self.fastTypeArray[tag][@"no"];
    self.comString = self.fastTypeArray[tag][@"com"];
    
    self.fastOldbutton.selected = NO;
    btn.selected = YES;
    self.fastOldbutton = btn;

}



//汇通：210788832797
//申通：868462239667
//圆通 100236365305

/**
 *  查询按钮点击，请求参数
 */
-(void)searchBtnClick:(UIButton *)button
{
    //从文件中取出原来的数据
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"];
    self.hisArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    NSDate * newDate = [NSDate date];
    NSDateFormatter*dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"yyyy.MM.dd"];
    NSString *newDateOne = [dateformat stringFromDate:newDate];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary ];
    [dict setValue:self.noString forKey:@"com"];
    [dict setValue:self.searchField.text forKey:@"no"];
    [dict setValue:self.comString forKey:@"name"];
    [dict setValue:newDateOne forKey:@"date"];
    
    [self.hisArray insertObject:dict atIndex:0];
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/exp/index" APIID:@"43" Parameters:dict Method:@"GET" Success:^(id responseObject) {
        
        if ([responseObject[@"resultcode"] isEqualToString:@"200"]) {
            self.dataDict = responseObject[@"result"];
            
            //保存到文件中
            NSString *pathFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"];
            [self.hisArray writeToFile:pathFile atomically:YES];
            
            
            
            FHFatMailDetailController *detailC = [[FHFatMailDetailController alloc]initWithStyle:(UITableViewStylePlain)];
           UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detailC];
           // FHNavController *nav = [[FHNavController alloc]initWithRootViewController:detailC];
            detailC.navtitle = self.comString;

            detailC.listArray = self.dataDict[@"list"];
            
            [self.navigationController presentViewController:nav animated:NO completion:nil];
        }else
        {
            [MBProgressHUD showError:@"您的快递单号或公司名称不正确"];
        }
        
    } Failure:^(NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];
}

#pragma mark - tableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hisCell"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"hisCell"];
    }
    
    NSString *name =self.historyData[indexPath.row][@"name"];
    NSString *number = self.historyData[indexPath.row][@"no"];
    NSString *date = self.historyData[indexPath.row][@"date"];
    NSString *str1 = [NSString stringWithFormat:@"%@  单号:%@",name,number];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = str1;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"上次查询:%@",date];
    cell.backgroundColor = [UIColor orangeColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *number = self.historyData[indexPath.row][@"no"];
    NSString *com =self.historyData[indexPath.row][@"com"];
    NSString *name = self.historyData[indexPath.row][@"name"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary ];
    [dict setValue:com forKey:@"com"];
    [dict setValue:number forKey:@"no"];
    
    JHAPISDK *juheapi = [JHAPISDK shareJHAPISDK];
    [juheapi executeWorkWithAPI:@"http://v.juhe.cn/exp/index" APIID:@"43" Parameters:dict Method:@"GET" Success:^(id responseObject) {
        
        if ([responseObject[@"resultcode"] isEqualToString:@"200"]) {
            self.dataDict = responseObject[@"result"];
            
            //从文件中取出原来的数据
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"];
            self.hisArray = [NSMutableArray arrayWithContentsOfFile:path];
            
            NSDate * newDate = [NSDate date];
            NSDateFormatter*dateformat=[[NSDateFormatter alloc]init];
            [dateformat setDateFormat:@"yyyy.MM.dd"];
            NSString *newDateOne = [dateformat stringFromDate:newDate];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary ];
            [dic setValue:com forKey:@"com"];
            [dic setValue:number forKey:@"no"];
            [dic setValue:name forKey:@"name"];
            [dic setValue:newDateOne forKey:@"date"];
            
            [self.hisArray insertObject:dic atIndex:0];
            

            //保存到文件中
            NSString *pathFile = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"history.plist"];
            [self.hisArray writeToFile:pathFile atomically:YES];

            FHFatMailDetailController *detailC = [[FHFatMailDetailController alloc]initWithStyle:(UITableViewStylePlain)];
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detailC];
            //FHNavController *nav = [[FHNavController alloc]initWithRootViewController:detailC];
            detailC.navtitle = self.comString;
            
            detailC.listArray = self.dataDict[@"list"];
            
            [self.navigationController presentViewController:nav animated:NO completion:nil];
        }else
        {
            [MBProgressHUD showError:@"您的快递单号或公司名称不正确"];
        }
        
    } Failure:^(NSError *error) {
        NSLog(@"error:   %@",error.description);
    }];

}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
