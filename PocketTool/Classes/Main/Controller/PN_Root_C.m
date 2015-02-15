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
#import "MBProgressHUD+PN.h"
#import "PN_Flash_C.h"
#import "PN_Package_C.h"
#import "PN_Finance_C.h"
#import "PN_Calculator_C.h"
#import "PN_Constrllation_C.h"
#import "FHFastMailViewController.h"
#import "PTTabBar.h"

@interface PN_Root_C ()
<
UIScrollViewDelegate,
PNTabBarDelegate,
PTTabBarDelegate
>
//日常工具数组

@property (nonatomic, readwrite) UIScrollView *bottomScrollView;
@property (nonatomic, readwrite) UIScrollView *toolsScrollView;
@property (nonatomic, readwrite) UIScrollView *servicesScrollView;
@property (nonatomic, readwrite) UIScrollView *readScrollView;
@property (nonatomic, readwrite) UIScrollView *mallScrollView;
@property (nonatomic,strong) UIScrollView *scroll;
@property (nonatomic,strong) UIImageView *backImage;
@property (nonatomic,strong) UIImage *BgImage;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *arr;
@end

@implementation PN_Root_C

- (void)viewDidLoad {
    [super viewDidLoad];
	
	CGRect rect = CGRectZero;
	rect.origin.y = self.view.bounds.size.height - [PTTabBar height];
	rect.size.width = self.view.bounds.size.width;
	rect.size.height = [PTTabBar height];
	
	PTTabBar *tabBar = [[PTTabBar alloc] initWithFrame:rect];
//	tabBar.
	tabBar.delegate = self;
	[self.view addSubview:tabBar];

	CGFloat heightOfBottomScrollView = 110;
	rect.origin.y = CGRectGetMinY(tabBar.frame) - heightOfBottomScrollView;
	rect.size.height = heightOfBottomScrollView;
	self.bottomScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.bottomScrollView.backgroundColor = [UIColor redColor];
	self.bottomScrollView.pagingEnabled = YES;
	self.bottomScrollView.delegate = self;
	[self.view addSubview:self.bottomScrollView];
	
	rect.origin.y = 0;
	self.toolsScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.toolsScrollView.backgroundColor = [UIColor blueColor];
	self.toolsScrollView.pagingEnabled = YES;
	self.toolsScrollView.contentSize = CGSizeMake(self.toolsScrollView.bounds.size.width * 2, self.toolsScrollView.bounds.size.height);
	[self.bottomScrollView addSubview:self.toolsScrollView];
	
	rect.origin.x = CGRectGetMaxX(self.toolsScrollView.frame);
	self.servicesScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.servicesScrollView.backgroundColor = [UIColor greenColor];
	self.servicesScrollView.pagingEnabled = YES;
	[self.bottomScrollView addSubview:self.servicesScrollView];
	
	rect.origin.x = CGRectGetMaxX(self.servicesScrollView.frame);
	self.readScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.readScrollView.backgroundColor = [UIColor grayColor];
	self.readScrollView.pagingEnabled = YES;
	[self.bottomScrollView addSubview:self.readScrollView];
	
	rect.origin.x = CGRectGetMaxX(self.readScrollView.frame);
	self.mallScrollView = [[UIScrollView alloc] initWithFrame:rect];
	self.mallScrollView.backgroundColor = [UIColor orangeColor];
	self.mallScrollView.pagingEnabled = YES;
	[self.bottomScrollView addSubview:self.mallScrollView];
	
	self.bottomScrollView.contentSize = CGSizeMake(self.bottomScrollView.bounds.size.width * 4, self.bottomScrollView.bounds.size.height);
	
	
    //绑定Juhe的ID
    [[JHOpenidSupplier shareSupplier] registerJuheAPIByOpenId:@"JH3d10c81c2da5d095c11b5537360a47ac"];
       /**
          //
          */
    //设置背景
    self.backImage = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.backImage.image = [UIImage imageNamed:@"bg2.jpg"];
    //[self.view addSubview:self.backImage];
    
    self.BgImage = [UIImage imageNamed:@"bg2.jpg"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changebg" object:self.BgImage];
    
    
    
    //设置工具条
    self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, mainH-(mainH*0.1)-(mainW*0.5), mainW, mainW*0.5)];
    self.scroll.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4f];
    //[self.view addSubview:self.scroll];
    
    //尺子
   PN_ToolButton_V *ruler = [[PN_ToolButton_V alloc]initWithTitle:@"尺子" andImage:@"gr_tool_ruler" andTarget:self action:@selector(ruler)];
    
    //手机归属地
    PN_ToolButton_V *searchPhone = [[PN_ToolButton_V alloc]initWithTitle:@"号码归属地" andImage:@"gr_search_phone" andTarget:self action:@selector(searchPhone)];
    
    //周公解梦
    PN_ToolButton_V *dream = [[PN_ToolButton_V alloc]initWithTitle:@"周公解梦" andImage:@"gr_tool_dream" andTarget:self action:@selector(dream)];
    
    //尺码对照表
    PN_ToolButton_V *sizes = [[PN_ToolButton_V alloc]initWithTitle:@"尺码对照表" andImage:@"gr_tool_sizes" andTarget:self action:@selector(sizes)];
    
    //镜子
    PN_ToolButton_V *mirror = [[PN_ToolButton_V alloc]initWithTitle:@"镜子" andImage:@"gr_tool_mirror" andTarget:self action:@selector(mirror)];
    
    //手电筒
    PN_ToolButton_V *flash = [[PN_ToolButton_V alloc]initWithTitle:@"手电筒" andImage:@"gr_tool_flash" andTarget:self action:@selector(flash)];
    
    //快递查询
    PN_ToolButton_V *package = [[PN_ToolButton_V alloc]initWithTitle:@"快递查询" andImage:@"gr_search_package" andTarget:self action:@selector(package)];
    
    //外汇汇率
    PN_ToolButton_V *currency = [[PN_ToolButton_V alloc]initWithTitle:@"外汇汇率" andImage:@"gr_tool_currency" andTarget:self action:@selector(currency)];
    
    //科学计算器
    PN_ToolButton_V *calculator = [[PN_ToolButton_V alloc]initWithTitle:@"科学计算器" andImage:@"gr_tool_calculator" andTarget:self action:@selector(calculator)];
    
    //星座运势
    PN_ToolButton_V *zodaic = [[PN_ToolButton_V alloc]initWithTitle:@"星座运势" andImage:@"gr_tool_zodaic" andTarget:self action:@selector(zodaic)];
    
    //日常工具数组
    NSArray *array1 = @[ruler,dream,sizes,flash,mirror,currency,calculator];
    NSArray *array2 = @[searchPhone,package];
    NSArray *array3 = @[zodaic];
    NSArray *array4 = @[];
    
    self.arr = @[array1,array2,array3,array4];
    //初始化TabBar
    //[self setupTabBar];
    
}

//更换背景
- (void)changebg:(NSNotification *)Notification
{
    self.backImage.image = (UIImage *)Notification.object;
}

- (void)setupTabBar
{
   PN_TabBar_V *tabbar = [[PN_TabBar_V alloc]initWithFrame:CGRectMake(0, mainH-(mainH*0.05), mainW, mainH*0.05)];
    tabbar.backgroundColor =[UIColor redColor];
    [self.view addSubview:tabbar];
    //设置代理
    tabbar.delegate = self;
    //默认选中0
    [self tabBar:tabbar didSelectButtonFrom:0 to:0];
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
//镜子
- (void)mirror
{
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    if (!isCamera) {
        
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // 编辑模式
    imagePicker.allowsEditing = YES;
    
    [self presentViewController:imagePicker animated:YES completion:^{
    }];
}
//手电筒
- (void)flash
{
    PN_Flash_C *Flash = [[PN_Flash_C alloc]init];
    [self presentViewController:Flash animated:NO completion:nil];
}
//快递查询
- (void)package
{
   [self.navigationController pushViewController:[[FHFastMailViewController alloc]init] animated:NO];
}

//外汇汇率
- (void)currency
{
    [self.navigationController pushViewController:[[PN_Finance_C alloc]init] animated:NO];
}
//科学计算器
- (void)calculator
{
    [self.navigationController pushViewController:[[PN_Calculator_C alloc]initWithNibName:@"PN_Calculator_C" bundle:nil] animated:NO];
}
//星座运势
- (void)zodaic
{
   [self.navigationController pushViewController:[[PN_Constrllation_C alloc]init] animated:NO];
}
//#pragma mark - TabBar的代理方法
//- (void)tabBar:(PN_TabBar_V *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
//{
//    self.array = self.arr[to];
//    //移除所有子控件
//    while (self.scroll.subviews.count>0)
//    {
//        [self.scroll.subviews.lastObject removeFromSuperview];
//    }
//    
//    //重设位置
//    //1，判断有几组数据
//   int group = (int)(self.array.count/8)+1;
//    //计数器
//    int count = 0;
//    //循环设置frame
//    for (int i=0; i<group; i++) {
//        for (int j=0; j<2; j++) {
//            for (int k=0; k<4; k++) {
//               PN_ToolButton_V *btn = self.array[count];
//                btn.frame = CGRectMake((k*btn.width)+(mainW*i),j*btn.height, btn.width, btn.height);
//                [self.scroll addSubview:btn];
//                if (count==self.array.count-1) {
//                    break;
//                }
//                count++;
//            }
//            if (count==self.array.count-1) {
//                break;
//            }
//        }
//        if (count==self.array.count-1) {
//            break;
//        }
//    }
//}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	if (scrollView == _bottomScrollView) {
		CGFloat pageWidth = scrollView.frame.size.width;
		NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
		[self ptTabBarSelectedAtIndex:page];
	}
}

#pragma mark - PTTabBarDelegate

- (void)ptTabBarSelectedAtIndex:(NSInteger)index {
	NSLog(@"selected index: %@", @(index));
	CGRect rect = _bottomScrollView.bounds;
	rect.origin.x = _bottomScrollView.bounds.size.width * index;
	[_bottomScrollView scrollRectToVisible:rect animated:NO];
}



@end
