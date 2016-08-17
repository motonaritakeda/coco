//
//  PopinfoSegmentSettingsViewController.m
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoSegmentSettingsViewController.h"
#import "PopinfoViewConfiguration.h"

@interface PopinfoSegmentSettingsViewController () <UIWebViewDelegate>

@end

@implementation PopinfoSegmentSettingsViewController

@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)dealloc
{
    self.webView = nil;
    
    [super dealloc];
}

#pragma mark - ViewController Delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [super startRequestWeb:self.webView];
}

#pragma mark - WebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:self.webView shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [super webView:self.webView didFailLoadWithError:error];
}

#pragma mark - 通信エラー時のダイアログ

- (void)showNetworkErrorAlertView
{
    // 通信エラー時のアラートを表示します

    // 表示文字列生成
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog5" value:@"Error" table:@"Localizable"];
    NSString *message = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog6" value:@"通信に失敗しました。通信状況の良い場所でもう一度お試しください。" table:@"Localizable"];
    NSString *buttonTitle = [[NSBundle mainBundle] localizedStringForKey:@"popinfoButton3" value:@"閉じる" table:@"Localizable"];
    
    // アラートの表示
    if (NSClassFromString(@"UIAlertController")) {
        // iOS8
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self finishSegmentSettingsView];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // iOS7以下
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil] autorelease];
        [alertView show];
        
    }
}

- (void)showNonUserIdAlertView
{
    // ユーザーID未取得の状態では属性設定画面を表示させることができないため、アラートを表示します。

    // 表示文字列生成
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog5" value:@"接続エラー" table:@"Localizable"];
    NSString *message = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog7" value:@"接続エラーが発生しました。通信状態の良好な場所でアプリを再起動してください。" table:@"Localizable"];
    NSString *buttonTitle = [[NSBundle mainBundle] localizedStringForKey:@"popinfoButton3" value:@"閉じる" table:@"Localizable"];
    
    // アラートの表示
    if (NSClassFromString(@"UIAlertController")) {
        // iOS8
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self finishSegmentSettingsView];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // iOS7以下
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil] autorelease];
        [alertView show];
        
    }
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self finishSegmentSettingsView];
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

#pragma mark - self delegate

- (void)finishSegmentSettingsView
{
    if ([self.delegate respondsToSelector:@selector(popinfoSegmentSettingsViewControllerDidFinishSetting:)]) {
        [self.delegate popinfoSegmentSettingsViewControllerDidFinishSetting:self];
    }
}

@end
