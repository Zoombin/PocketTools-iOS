//
//  PN_Phone_C.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//
#define magin 10

#import "PN_Phone_C.h"
#import "PN_Pocket_Network.h"
#import "PN_Phone_M.h"

@interface PN_Phone_C ()
//号码输入框
@property (nonatomic,strong) UITextField *phonetext;
//返回数据模型
@property (nonatomic,strong) PN_Phone_M *Pmodel;
//查询按钮
@property (nonatomic,strong) UIButton *searchBtn;
//展示信息的view
@property (nonatomic,strong) UIView *Infoview;
@property (nonatomic,strong) UIImageView *backImage;
@end

@implementation PN_Phone_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //绑定
    JUHE;
    //设置背景
    self.backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.backImage.image = [UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:self.backImage];
    
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    //标题
    self.title = @"手机归属地";
    
    //手机号输入框
    UITextField *phonetext = [[UITextField alloc]initWithFrame:CGRectMake(magin, 74, mainW*0.75, mainH*0.1)];
    phonetext.backgroundColor =[UIColor grayColor];
    phonetext.keyboardType = UIKeyboardTypeNumberPad;
    phonetext.placeholder = @"手机号码";
    phonetext.textColor = [UIColor whiteColor];
    [self.view addSubview:phonetext];
    self.phonetext = phonetext;
    
    //查询
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(phonetext.frame)+magin, 74, mainW-phonetext.width-(3*magin), mainH*0.1)];
    [searchBtn setBackgroundColor:[UIColor whiteColor]];
    [searchBtn setTitle:@"查询" forState:(UIControlStateNormal)];
    [searchBtn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [searchBtn addTarget:self action:@selector(search) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:searchBtn];
    self.searchBtn = searchBtn;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.phonetext becomeFirstResponder];
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

//查询点击事件
- (void)search
{
    [self.phonetext resignFirstResponder];
    if (self.phonetext.text.length != 11) {
        [MBProgressHUD showError:@"您输入的手机号有误"];
        return;
    }
    NSNumber *num = [NSNumber numberWithLongLong:[self.phonetext.text longLongValue]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:num forKey:@"phone"];
    [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:@"http://apis.juhe.cn/mobile/get" APIID:@"11" Parameters:params Method:@"GET" Success:^(id responseObject) {
        if (![[responseObject valueForKey:@"reason"] isEqualToString:@"Empty"]) {
            self.Pmodel = [PN_Phone_M objectWithKeyValues:responseObject[@"result"]];
        }else{
            [MBProgressHUD showError:@"找不到该号码"];
            return ;
        }
        //创建信息
        [self createInfoView];
        
    } Failure:^(NSError *error) {
        [MBProgressHUD showError:@"请求失败"];
    }];
}
//展示返回信息
- (void)createInfoView
{
    if (self.Infoview !=nil) {
        [self.Infoview removeFromSuperview];
        self.Infoview = nil;
    }
    //信息展示view
   self.Infoview = [[UIView alloc]initWithFrame:CGRectMake(magin, CGRectGetMaxY(self.phonetext.frame)+(magin/2), mainW-(2*magin), 210)];
    [self.view addSubview:self.Infoview];
    //省份
   UILabel *province = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Infoview.width, 30)];
    province.text =[NSString stringWithFormat:@"省份：%@",self.Pmodel.province];
    [self.Infoview addSubview:province];
    
    //城市
    UILabel *city = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(province.frame)+(magin/2), self.Infoview.width, 30)];
    city.text =[NSString stringWithFormat:@"城市：%@",self.Pmodel.city];
    [self.Infoview addSubview:city];
    
    //区号
    UILabel *areacode = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(city.frame)+(magin/2), self.Infoview.width, 30)];
    areacode.text =[NSString stringWithFormat:@"区号：%@",self.Pmodel.areacode];
    [self.Infoview addSubview:areacode];
    
    //邮编
    UILabel *zip = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(areacode.frame)+(magin/2), self.Infoview.width, 30)];
    zip.text =[NSString stringWithFormat:@"邮编：%@",self.Pmodel.zip];
    [self.Infoview addSubview:zip];
    
    //运营商
    UILabel *company = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(zip.frame)+(magin/2), self.Infoview.width, 30)];
    company.text =[NSString stringWithFormat:@"运营商：%@",self.Pmodel.company];
    [self.Infoview addSubview:company];
    
    //卡类型
    UILabel *card = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(company.frame)+(magin/2), self.Infoview.width, 30)];
    card.text =[NSString stringWithFormat:@"卡类型：%@",self.Pmodel.card];
    [self.Infoview addSubview:card];
}

@end
