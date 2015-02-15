//
//  PN_Constrllation_C.m
//  PocketTool
//
//  Created by Mac on 15-2-12.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Constrllation_C.h"
#import "PN_AllConstrll_C.h"
@interface PN_Constrllation_C ()
//日期类型
@property (nonatomic,copy)NSString *type;

@property (nonatomic,strong) UIView *InfoView;

@property (nonatomic,strong) UIScrollView *scroll;
@end

@implementation PN_Constrllation_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册
    JUHE;
    
    //标题
    self.title = @"今日运势";
    
    //所有星座按钮
   UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    [button setTitle:@"所有星座" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(ALLconstella) forControlEvents:(UIControlEventTouchUpInside)];
   self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    //创建返回按钮
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [back setImage:[UIImage imageWithName:@"UIBarButtonItemArrowLeft"] forState:(UIControlStateNormal)];
    [back addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    //创建底部按钮
    NSArray *btnArr= @[@"今日",@"明日",@"本周",@"下周",@"本月",@"今年"];
    
   self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, mainH-30, mainW, 30)];
    [self.view addSubview:self.scroll];
    CGFloat btnW = mainW/3;
    int count = (int)btnArr.count;
    for (int i=0; i<count; i++) {
       UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnW, -64, btnW, 30)];
        [self.scroll addSubview:btn];
        btn.backgroundColor =[UIColor redColor];
        btn.tag = i;
        [btn setTitle:btnArr[i] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [btn setBackgroundImage:[UIImage imageWithName:@"btn_passnum_dn"] forState:(UIControlStateSelected)];
        [btn addTarget:self action:@selector(typeClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    //滚动范围
    self.scroll.contentSize = CGSizeMake(count*btnW, 0);
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.showsHorizontalScrollIndicator = NO;
    
    self.scroll.backgroundColor =[UIColor yellowColor];
    
//    NSDictionary
//    [self getInfoWithDictionary:<#(NSDictionary *)#>]
}
//返回
- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
}

//所有星座点击事件
- (void)ALLconstella
{
    [self.navigationController pushViewController:[[PN_AllConstrll_C alloc]init] animated:YES];
}

- (void)getInfoWithDictionary:(NSDictionary *)dictionary
{
   [[JHAPISDK shareJHAPISDK] executeWorkWithAPI:@"http://web.juhe.cn:8080/constellation/getAll" APIID:@"58" Parameters:dictionary Method:@"GET" Success:^(id responseObject) {
       
   } Failure:^(NSError *error) {
       
   }];
}
- (void)typeClick:(UIButton *)btn
{
    //切换type
   NSArray *typeArr = @[@"today",@"tomorrow",@"week",@"nextweek",@"month",@"year"];
    self.type = typeArr[btn.tag];
    
    if (self.InfoView) {
        [self.InfoView removeFromSuperview];
        self.InfoView =nil;
    }
    switch (btn.tag) {
        case 0:
            
            break;
            
        default:
            break;
    }
}
@end
