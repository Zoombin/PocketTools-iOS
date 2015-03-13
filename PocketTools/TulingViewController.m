//
//  TulingViewController.m
//  PocketTools
//
//  Created by yc on 15-3-3.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "TulingViewController.h"
#import "RobotInfo.h"
#import "LeftContactCell.h"
#import "RightContactCell.h"

@interface TulingViewController ()

@end

@implementation TulingViewController {
    NSMutableArray *infoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    infoArray = [NSMutableArray array];
    self.title = NSLocalizedString(@"聊天机器人", nil);
    // Do any additional setup after loading the view from its nib.
    [self chatWithRobot:@"你好"];
    infoArray = [NSMutableArray array];
}

- (void)chatWithRobot:(NSString *)content {
    _textField.text = @"";
    [[ServiceRequest shared] chatWithRobot:content withBlock:^(NSDictionary *result, NSError *error) {
        if (!error) {
            ServiceResult *resultInfo= [[ServiceResult alloc] initWithAttributes:result];
            if ([resultInfo.resultcode integerValue] == 0) {
                RobotInfo *info = [[RobotInfo alloc] init];
                info.text = resultInfo.result[@"text"];
                info.isLeft = YES;
                [infoArray addObject:info];
                [_tableView reloadData];
            }
        }
    }];
}

- (IBAction)sendButto:(id)sender {
    [_textField resignFirstResponder];
    if ([_textField.text isEqualToString:@""]) {
        [self displayHUDTitle:nil message:@"请输入内容!" duration:DELAY_TIMES];
        return;
    }
    RobotInfo *info = [[RobotInfo alloc] init];
    info.text = _textField.text;
    info.isLeft = NO;
    [infoArray addObject:info];
    [_tableView reloadData];
    
    [self chatWithRobot:_textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self sendButto:nil];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [infoArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    RobotInfo *info = infoArray[indexPath.row];
    if (info.isLeft) {
        LeftContactCell *leftCell = (LeftContactCell *)cell;
        return [leftCell getHeight];
    } else {
        RightContactCell *rightCell = (RightContactCell *)cell;
        return [rightCell getHeight];
    }
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    RobotInfo *info = infoArray[indexPath.row];
    if (info.isLeft) {
        LeftContactCell *cell = (LeftContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"LeftContactCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.contentLabel.text = info.text;
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentLabel sizeToFit];
        
        [cell.backgroundImage setFrame:CGRectMake(cell.backgroundImage.frame.origin.x, cell.backgroundImage.frame.origin.y, cell.backgroundImage.frame.size.width, CGRectGetMaxY(cell.contentLabel.frame) + 10)];
        
        [cell.headerImage setFrame:CGRectMake(cell.headerImage.frame.origin.x, CGRectGetMaxY(cell.backgroundImage.frame) - cell.headerImage.frame.size.height + 15, cell.headerImage.frame.size.width, cell.headerImage.frame.size.height)];
        return cell;
    } else {
        RightContactCell *cell = (RightContactCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"RightContactCell" owner:nil options:nil];
            cell = [nibs lastObject];
            cell.backgroundColor = [UIColor clearColor];
        }
        cell.contentLabel.text = info.text;
        cell.contentLabel.numberOfLines = 0;
        cell.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [cell.contentLabel sizeToFit];

        [cell.backgroundImage setFrame:CGRectMake(cell.backgroundImage.frame.origin.x, cell.backgroundImage.frame.origin.y, cell.backgroundImage.frame.size.width, CGRectGetMaxY(cell.contentLabel.frame) + 10)];
        
        [cell.headerImage setFrame:CGRectMake(cell.headerImage.frame.origin.x, CGRectGetMaxY(cell.backgroundImage.frame) - cell.headerImage.frame.size.height + 15, cell.headerImage.frame.size.width, cell.headerImage.frame.size.height)];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
