//
//  PackageSearchViewController.m
//  PocketTools
//
//  Created by 颜超 on 15/3/7.
//  Copyright (c) 2015年 yc. All rights reserved.
//

#import "PackageSearchViewController.h"
#import "PackageDetailViewController.h"

@interface PackageSearchViewController ()

@end

@implementation PackageSearchViewController {
    NSArray *searchHistory;
    NSArray *postmansArray;
    NSArray *postmanSimplesArray;
    NSMutableArray *postmanBtnsArray;
    NSInteger currentPostMan;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"快递", nil);
    currentPostMan = 0;
    postmansArray = @[@"顺丰", @"申通", @"圆通", @"韵达", @"天天", @"EMS", @"中通", @"汇通"];
    postmanSimplesArray = @[@"sf", @"sto", @"yt", @"yd", @"tt", @"ems", @"zto", @"ht"];
    
    postmanBtnsArray = [NSMutableArray array];
    
    [_tableView setTableHeaderView:_headerView];
    [self initButtons];
    [self postmanButtonClicked:postmanBtnsArray[0]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getSearchHistory];
}

- (void)initButtons {
    CGFloat offSetX = 20;
    CGFloat buttonWidth = ([UIScreen mainScreen].bounds.size.width - offSetX * 5) / 4;
    CGFloat buttonHeight = 30;
    int line = 0;
    int index = 0;
    for (int i = 0; i < [postmansArray count]; i++) {
        if (i != 0 && i % 4 == 0) {
            line++;
            index = 0;
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(offSetX * (index + 1) + buttonWidth * index, 10 * (line + 1) + line * buttonHeight, buttonWidth, buttonHeight)];
        [button addTarget:self action:@selector(postmanButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button setTag:i];
        [button setTitle:postmansArray[i] forState:UIControlStateNormal];
        [_headerView addSubview:button];
        [postmanBtnsArray addObject:button];
        index++;
    }
}

- (IBAction)searchButtonClicked:(id)sender {
    [_codeTextField resignFirstResponder];
    if ([_codeTextField.text isEqualToString:@""] || [_codeTextField.text length] == 0) {
        [self displayHUDTitle:nil message:@"请输入内容!" duration:DELAY_TIMES];
        return;
    }
    NSDictionary *dict = @{@"com" : postmanSimplesArray[currentPostMan], @"no" : _codeTextField.text, @"name" : postmansArray[currentPostMan]};
    [[ServiceRequest shared] savePostManSearch:dict];
    PackageDetailViewController *viewCtrl = [PackageDetailViewController new];
    viewCtrl.postCompany = postmanSimplesArray[currentPostMan];
    viewCtrl.postNum = _codeTextField.text;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self searchButtonClicked:nil];
    return YES;
}

- (void)postmanButtonClicked:(id)sender {
    [self allButtonClearColor];
    UIButton *button = (UIButton *)sender;
    currentPostMan = button.tag;
    [button setBackgroundColor:[UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0]];
}

- (void)allButtonClearColor {
    for (UIButton *button in postmanBtnsArray) {
        [button setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchHistory count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    NSDictionary *historyInfo = searchHistory[indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", historyInfo[@"name"], historyInfo[@"no"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *historyInfo = searchHistory[indexPath.row];
    PackageDetailViewController *viewCtrl = [PackageDetailViewController new];
    viewCtrl.postCompany = historyInfo[@"com"];
    viewCtrl.postNum = historyInfo[@"no"];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (void)getSearchHistory {
    searchHistory = [[ServiceRequest shared] getPostManSearch];
    [_tableView reloadData];
}


@end
