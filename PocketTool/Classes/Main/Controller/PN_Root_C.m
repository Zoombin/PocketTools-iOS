//
//  PN_Root_C.m
//  PocketTool
//
//  Created by Mac on 15-2-8.
//  Copyright (c) 2015年 PN. All rights reserved.
//

#import "PN_Root_C.h"
#import "PN_TabBar_V.h"
#import "PN_ToolButton_V.h"
#import "PN_Ruler_C.h"
#import "PN_Phone_C.h"
#import "PN_Dream_C.h"
#import "PN_Sizes_C.h"
@interface PN_Root_C ()
<
PNTabBarDelegate
>
//日常工具数组
@property (nonatomic,strong) NSArray *array1;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) UIImage *BgImage;
@end

@implementation PN_Root_C

- (void)viewDidLoad {
    [super viewDidLoad];
    //绑定Juhe的ID
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH3d10c81c2da5d095c11b5537360a47ac"];
    
    //设置背景
    self.backImage = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.backImage.image = [UIImage imageNamed:@"bg2.jpg"];
    [self.view addSubview:self.backImage];
    
    self.BgImage = [UIImage imageNamed:@"bg2.jpg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changebg" object:self.BgImage];
    
    //初始化TabBar
    [self setupTabBar];
    
    //设置工具条
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, mainH-(mainH*0.1)-(mainW*0.5), mainW, mainW*0.5)];
    self.scroll.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4f];
    [self.view addSubview:self.scroll];
    
    //尺子
   PN_ToolButton_V *ruler = [[PN_ToolButton_V alloc]initWithTitle:@"尺子" andImage:@"gr_tool_ruler" andTarget:self action:@selector(ruler)];
    
    //手机归属地
    PN_ToolButton_V *searchPhone = [[PN_ToolButton_V alloc]initWithTitle:@"号码归属地" andImage:@"gr_search_phone" andTarget:self action:@selector(searchPhone)];
    
    //周公解梦
    PN_ToolButton_V *dream = [[PN_ToolButton_V alloc]initWithTitle:@"周公解梦" andImage:@"gr_tool_dream" andTarget:self action:@selector(dream)];
    
    //尺码对照表
    PN_ToolButton_V *sizes = [[PN_ToolButton_V alloc]initWithTitle:@"尺码对照表" andImage:@"gr_tool_sizes" andTarget:self action:@selector(sizes)];
    //日常工具数组
    self.array1 = @[ruler,searchPhone,dream,sizes];
    //设置按钮在scroll里的位置
    [self setToolBtnframe];
}

//更换背景
- (void)changebg:(NSNotification *)Notification
{
    self.backImage.image = (UIImage *)Notification.object;
}
- (void)setToolBtnframe
{
    int count = (int)self.array1.count;
    for (int i=0; i<count; i++) {
       PN_ToolButton_V *btn = self.array1[i];
        btn.frame = CGRectMake(i*btn.width, 0, btn.width, btn.height);
        [self.scroll addSubview:btn];
    }
   
}
- (void)setupTabBar
{
   PN_TabBar_V *tabbar = [[PN_TabBar_V alloc]initWithFrame:CGRectMake(0, mainH-(mainH*0.05), mainW, mainH*0.05)];
    tabbar.backgroundColor =[UIColor redColor];
    [self.view addSubview:tabbar];
    //设置代理
    tabbar.delegate = self;
}
//尺子
- (void)ruler
{
    PN_Ruler_C *ruler = [[PN_Ruler_C alloc]init];
    [self presentViewController:ruler animated:NO completion:nil];
}
//手机归属地
- (void)searchPhone
{
    [self.navigationController pushViewController:[[PN_Phone_C alloc]init] animated:NO];
}
//周公解梦
- (void)dream
{
    [self.navigationController pushViewController:[[PN_Dream_C alloc]init] animated:NO];
}
//尺码对照
- (void)sizes
{
   [self.navigationController pushViewController:[[PN_Sizes_C alloc]init] animated:NO];
}
#pragma mark - TabBar的代理方法
- (void)tabBar:(PN_TabBar_V *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
{
  
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
