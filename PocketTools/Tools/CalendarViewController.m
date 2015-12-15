//
//  CalendarViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/12.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "CalendarViewController.h"
#import "JBCalendarLogic.h"
#import "JBUnitView.h"
#import "JBUnitGridView.h"
#import "CalandarTitleView.h"
#import "CalandarInfo.h"


@interface CalendarViewController () <JBUnitGridViewDelegate, JBUnitGridViewDataSource, JBUnitViewDelegate, JBUnitViewDataSource>

@property (nonatomic, retain) JBUnitView *unitView;

- (void)selectorForButton;

@end

@implementation CalendarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _scrollView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _scrollView.frame.size.width) / 2, _scrollView.frame.origin.y, _scrollView.frame.size.width, _scrollView.frame.size.height);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(selectorForButton)];
    
    [self.view setUserInteractionEnabled:YES];
    self.unitView = [[JBUnitView alloc] initWithFrame:_scrollView.bounds UnitType:UnitTypeMonth SelectedDate:[NSDate date] AlignmentRule:JBAlignmentRuleTop Delegate:self DataSource:self];
    [_scrollView addSubview:self.unitView];
    
     _contentView.frame = CGRectMake(0.0f, self.unitView.frame.size.height + 5, _scrollView.frame.size.width, _contentView.frame.size.height);
      _scrollView.contentSize  = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_contentView.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Class Extensions
- (void)selectorForButton
{
    [self.unitView selectDate:[NSDate date]];
}

#pragma mark -
#pragma mark - JBUnitGridViewDelegate
/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的高度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前unitGridView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


/**************************************************************
 *@Description:获取当前UnitGridView中UnitTileView的宽度
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:当前UnitGridView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitGridView:(JBUnitGridView *)unitGridView
{
    return 46.0f;
}


//  ------------选中了当前月份或周之外的时间--------------
/**************************************************************
 *@Description:选中了当前Unit的上一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnPreviousUnitWithDate:(JBCalendarDate *)date
{
    
}

/**************************************************************
 *@Description:选中了当前Unit的下一个Unit中的时间点
 *@Params:
 *  unitGridView:当前unitGridView
 *  date:选中的时间点
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView selectedOnNextUnitWithDate:(JBCalendarDate *)date
{
    
}

#pragma mark -
#pragma mark - JBUnitGridViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    return [[CalandarTitleView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitGridView中的weekdaysBarView
 *@Params:
 *  unitGridView:当前unitGridView
 *@Return:weekdaysBarView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitGridView:(JBUnitGridView *)unitGridView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}


/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitGridView:当前unitGridView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitGridView:(JBUnitGridView *)unitGridView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}


#pragma mark -
#pragma mark - JBUnitViewDelegate
/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的高度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的高度
 **************************************************************/
- (CGFloat)heightOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}

/**************************************************************
 *@Description:获取当前UnitView中UnitTileView的宽度
 *@Params:
 *  unitView:当前unitView
 *@Return:当前UnitView中UnitTileView的宽度
 **************************************************************/
- (CGFloat)widthOfUnitTileViewsInUnitView:(JBUnitView *)unitView
{
    return 46.0f;
}


/**************************************************************
 *@Description:更新unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatingFrameTo:(CGRect)newFrame
{
    _contentView.frame = CGRectMake(0.0f, newFrame.size.height + 5, _scrollView.frame.size.width, _contentView.frame.size.height);
    _scrollView.contentSize  = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(_contentView.frame));
}

/**************************************************************
 *@Description:重新设置unitView的frame
 *@Params:
 *  unitView:当前unitView
 *  newFrame:新的frame
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView UpdatedFrameTo:(CGRect)newFrame
{
    //NSLog(@"OK");
}

#pragma mark -
#pragma mark - JBUnitViewDataSource
/**************************************************************
 *@Description:获得unitTileView
 *@Params:
 *  unitView:当前unitView
 *@Return:unitTileView
 **************************************************************/
- (JBUnitTileView *)unitTileViewInUnitView:(JBUnitView *)unitView
{
    return [[CalandarTitleView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 46.0f, 46.0f)];
}

/**************************************************************
 *@Description:设置unitView中的weekdayView
 *@Params:
 *  unitView:当前unitView
 *@Return:weekdayView
 **************************************************************/
- (UIView *)weekdaysBarViewInUnitView:(JBUnitView *)unitView
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weekdaysBarView"]];
    return imageView;
}

/**************************************************************
 *@Description:选择某一天
 *@Params:
 *  unitView:当前unitView
 *  date:选择的日期
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView SelectedDate:(NSDate *)date
{
    NSLog(@"selected date:%@", date);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSString *dateString = [formatter stringFromDate:date];
    self.title = dateString;
    [self getCalandarInfo:dateString];
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件的数量
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView NumberOfEventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSInteger eventCount))completedBlock
{
    completedBlock(calendarDate.day);
}

/**************************************************************
 *@Description:获取calendarDate对应的时间范围内的事件
 *@Params:
 *  unitView:当前unitView
 *  calendarDate:时间范围
 *  completedBlock:回调代码块
 *@Return:nil
 **************************************************************/
- (void)unitView:(JBUnitView *)unitView EventsInCalendarDate:(JBCalendarDate *)calendarDate WithCompletedBlock:(void (^)(NSArray *events))completedBlock
{
    completedBlock(nil);
}

- (void)getCalandarInfo:(NSString *)date {
    [self displayHUD:@"加载中..."];
    [[ServiceRequest shared] laohuangli:date withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.error_code integerValue] == 0) {
                [self hideHUD:YES];
                CalandarInfo *info = [[CalandarInfo alloc] initWithAttributes:resultInfo.result];
                [self showInfo:info];
            } else {
                [self displayHUDTitle:nil message:resultInfo.reason duration:DELAY_TIMES];
            }
        } else {
            [self displayHUDTitle:nil message:NETWORK_ERROR duration:DELAY_TIMES];
        }
    }];
}

- (void)showInfo:(CalandarInfo *)info {
    _contentView.text = [NSString stringWithFormat:@"阳历:%@\n五行:%@\n冲煞:%@\n百忌:%@\n吉神:%@\n凶神:%@\n宜:%@\n忌:%@", info.yinli, info.wuxing, info.chongsha, info.baiji, info.jishen, info.xiongshen, info.yi, info.ji];
}
@end
