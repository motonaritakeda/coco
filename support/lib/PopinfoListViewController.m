//
//  PopinfoListViewController.m
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoListViewController.h"
#import "PopinfoDetailViewController.h"
#import "PopinfoViewConfiguration.h"
#import "PopinfoMessage.h"

@interface PopinfoListViewController () {
    NSDateFormatter *formatter;
}

@end

@implementation PopinfoListViewController

@synthesize listTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    // 年月日ラベル用フォーマッタ
    formatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [formatter setCalendar:calendar];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    [calendar release];
    
    return self;
}

- (void)dealloc
{
    [formatter release];
    self.listTableView = nil;    
    
    [super dealloc];
}

#pragma mark - ViewController Delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    
    
    /*
    openmenuButton_info = [[tapArea alloc] initWithFrame:CGRectMake(128.0f, 6.0f, 64.0f, 32.0f)];
    openmenuButton_info.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *open_path = [[NSString alloc] init];
    open_path = [[NSBundle mainBundle] pathForResource:@"menu_info2" ofType:@"png"];
    [openmenuButton_info setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:open_path] forState:UIControlStateNormal];
    [openmenuButton_info addTarget:self action:@selector(openmenu) forControlEvents:UIControlEventTouchUpInside];
    [listTableView addSubview:openmenuButton_info];
    */
    /*
    openmenuButton_info = [[tapArea alloc] initWithFrame:CGRectMake(128.0f, 6.0f, 64.0f, 32.0f)];
    openmenuButton_info.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *open_path = [[NSString alloc] init];
    open_path = [[NSBundle mainBundle] pathForResource:@"menu_info2" ofType:@"png"];
    [openmenuButton_info setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:open_path] forState:UIControlStateNormal];
    [openmenuButton_info addTarget:self action:@selector(closemenu) forControlEvents:UIControlEventTouchUpInside];
    [listTableView addSubview:openmenuButton_info];
    */
}

-(void)openmenu{
    [[UIApplication sharedApplication].delegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.listTableView reloadData];
    
}
/*
-(void)closemenu{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        if (screenSize.height == 568.0f) {
            saftyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 548.0f)];
            [saftyView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
            [[self view] addSubview:saftyView];
        }
        else{
            saftyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 460.0f)];
            [saftyView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
            [[self view] addSubview:saftyView];
        }
    }
    else{
        if (screenSize.height == 568.0f) {
            saftyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 548.0f)];
            [saftyView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
            [[self view] addSubview:saftyView];
        }
        else{
            saftyView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 460.0f)];
            [saftyView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
            [[self view] addSubview:saftyView];
        }
    }
    
    
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.2f];
    [UIView setAnimationDidStopSelector:@selector(closeOk)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [UIView commitAnimations];
}
*/

/*
-(void)closeOk{
    [saftyView removeFromSuperview];
    NSLog(@"クローズOK");
    
    //[self dismissModalViewControllerAnimated:YES];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:0 forKey:@"menuFlag"];
    [userDefaults synchronize];
}
*/

#pragma mark - TableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 行の中身を生成します
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *timeLabel;
    UILabel *titleLabel;
    //PopinfoMessage *selectedMessage = [_messages objectAtIndex:indexPath.row];
    //int testInt = [selectedMessage.piId intValue];
    
    if (!cell) {
        // セル全体
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];
        
        // 年月日ラベル（セル右側）
        timeLabel = [[UILabel alloc] init];
        timeLabel.numberOfLines = 1;
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.textColor = [UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1];
        timeLabel.tag = kListViewLabelTagForTime;
        [cell.contentView addSubview:timeLabel];
        [timeLabel release];
        
        // タイトルラベル（セル左側）
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 3;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.tag = kListViewLabelTagForTitle;
        [cell.contentView addSubview:titleLabel];
        [titleLabel release];
    }
    
    // サイズの決定
    
    // セル全体
    cell.frame = CGRectMake(0, 0, self.view.bounds.size.width, kListViewCellHeight);
    
    // 年月日ラベル（セル右側）
    timeLabel = (UILabel *)[cell viewWithTag:kListViewLabelTagForTime];
    timeLabel.frame = CGRectMake(cell.frame.size.width - kListViewTimeLabelWidth, 0, kListViewTimeLabelWidth, kListViewTimeLabelHeight);
    
    // タイトルラベル（セル左側）
    titleLabel = (UILabel *)[cell viewWithTag:kListViewLabelTagForTitle];
    titleLabel.frame = CGRectMake(kListViewHorizontalMargin, 0, cell.frame.size.width - kListViewHorizontalMargin - kListViewHorizontalMarginBetweenTitleAndTime - kListViewTimeLabelWidth, kListViewCellHeight);

    // ラベルの表示文字列
    if (indexPath.row < [_messages count]) {
        PopinfoMessage *message = [_messages objectAtIndex:indexPath.row];
        timeLabel.text = [formatter stringFromDate:message.piTime];
        titleLabel.text = message.piTitle;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        // 既読の配信タイトルをグレーにしたい場合
        if (kListViewColorUseWhenRead) {
            NSNumber *unread = [[[NSNumber alloc] initWithInt:stateUnread] autorelease];
            if (![message.piUnread isEqualToNumber:unread]) {
                titleLabel.textColor = [UIColor grayColor];
            }
        }
        
    } else {
        // 空行
        timeLabel.text = @"";
        titleLabel.text = @"";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 行の高さを決定します
    return kListViewCellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 行の背景色を設定します
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 行をタップした際の動作を記述します
    
    if (indexPath.row < [_messages count]) {
        PopinfoMessage *selectedMessage = [_messages objectAtIndex:indexPath.row];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && kIpadSplitViewUse) {
            // iPad かつ PopinfoPadViewController(UISplitViewController)を使用する時
            UINavigationController *detailNav = [self.splitViewController.viewControllers objectAtIndex:1];
            PopinfoDetailViewController *detailVC = [detailNav.viewControllers objectAtIndex:0];
            detailVC.messageId = [selectedMessage.piId intValue];
            [detailVC reloadMyViews];
            
        } else {
            // iPhone時
            // 詳細画面に遷移する
            PopinfoDetailViewController *detailVC =[[[PopinfoDetailViewController alloc] initWithNibName:@"PopinfoDetailViewController" bundle:nil] autorelease];
            detailVC.messageId = [selectedMessage.piId intValue];
            [self.navigationController pushViewController:detailVC animated:YES];
            
            NSLog(@"idは%@",selectedMessage.piId);
        }
        
    }
    return;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [super maxMessageNumber];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Category

- (NSString *)category
{
    return _category;
}

- (void)setCategory:(NSString *)cat
{
    _category = cat;
    [super reloadMessagesWithCategory];
    [self.listTableView reloadData];
}

#pragma mark - Message Update

- (void)popinfoMessageWillUpdate
{
    [super popinfoMessageWillUpdate];
}

- (void)popinfoMessageDidUpdate
{
    [super popinfoMessageDidUpdate];
    [self reloadMessagesWithCategory];
    [self.listTableView reloadData];
}

#pragma mark - Rotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // iOS5以下の回転
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad && kIpadSplitViewUse) {
        return YES;
        
    } else {
        if (kRotateUse) {
            return YES;
        } else {
            return (interfaceOrientation == UIInterfaceOrientationPortrait);
        }
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // 回転終了後
    [self reloadMessagesWithCategory];
    [self.listTableView reloadData];
}

#pragma mark - SplitView（PopinfoPadViewControllerを利用する場合のみ）

- (void)selectRowAtMessageId:(NSInteger)messageId
{
    for (NSInteger i = 0; i < [_messages count]; i++) {
        PopinfoMessage *message = [_messages objectAtIndex:i];
        if ([message.piId integerValue] == messageId) {
            [self.listTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

@end
