//
//  PopinfoDetailViewController.m
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoDetailViewController.h"
#import "PopinfoViewConfiguration.h"
#import "PopinfoAsyncImageView.h"
#import "PopinfoMessage.h"
#import "PopinfoEventTrackingController.h"

@interface PopinfoDetailViewController () <UIWebViewDelegate> {
    float currentY;
    float iconY;
    float titleLabelY;
    float contentsLabelY;
    float contentsHtmlY;
    float underLine1Y;
    float underLine2Y;
    UIBarButtonItem *openUrlButton;
    UILabel *appliNameLabel;
    UILabel *titleLabel;
    UILabel *contentsLabel;
    UIView *underLine1View;
    UIView *underLine2View;
    UIWebView *contentsWebView;
    UIView *progressBackgroundView;
    UIView *progressBoxView;
    UILabel *progressLabel;
    UIActivityIndicatorView *indicator;
    PopinfoAsyncImageView *iconImageView;
}

@end

@implementation PopinfoDetailViewController

@synthesize basicScrollView;
@synthesize masterPopoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)dealloc
{
    self.basicScrollView = nil;
    self.masterPopoverController = nil;
    [contentsLabel release];
    [contentsWebView release];
    
    [super dealloc];
}

#pragma mark - ViewController Delegate

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateMyViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadMyViews];
    [self arrangeProgressDialog];
    [self changeColorOfUrlButton];
    contentsWebView.scalesPageToFit = YES;
}

#pragma mark - Rendering

- (void)generateMyViews
{
    // ビューの生成
    
    // URLを開くボタンの配置
    NSString *openUrlButtonStr = [[NSBundle mainBundle] localizedStringForKey:@"popinfoButton1" value:@"URLを開く" table:kLocalizableStrings];
    openUrlButton = [[UIBarButtonItem alloc] initWithTitle:openUrlButtonStr style:UIBarButtonItemStylePlain target:self action:@selector(didSelectOpenUrl)];
    self.navigationItem.rightBarButtonItem = openUrlButton;
    [openUrlButton release];
    
    // アイコン
    currentY = kDetailViewVerticalUpperMargin;
    iconY = currentY;
    iconImageView = [[PopinfoAsyncImageView alloc] init];
    [self.basicScrollView addSubview:iconImageView];
    //self.basicScrollView.scalesPageToFit = YES;
    [iconImageView release];
    
    // アプリ名
    appliNameLabel = [[UILabel alloc] init];
    appliNameLabel.text = _message.piShop;
    appliNameLabel.numberOfLines = 2;
    appliNameLabel.font = [UIFont boldSystemFontOfSize:20];
    appliNameLabel.textColor = [UIColor grayColor];
    [self.basicScrollView addSubview:appliNameLabel];
    [appliNameLabel release];
    
    // 区切り線1
    currentY += kDetailViewIconHeight + 5;
    underLine1Y = currentY;
    underLine1View = [[UIView alloc] init];
    underLine1View.backgroundColor = [UIColor grayColor];
    [self.basicScrollView addSubview:underLine1View];
    [underLine1View release];
    
    // タイトル
    currentY += kDetailViewUnderLineHeight + 3;
    titleLabelY = currentY;
    titleLabel = [[UILabel alloc] init];
    titleLabel.text = _message.piTitle;
    titleLabel.numberOfLines = 3;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    [self.basicScrollView addSubview:titleLabel];
    [titleLabel release];
    
    // 区切り線2
    currentY += kDetailViewTitleHeight + 3;
    underLine2Y = currentY;
    underLine2View = [[UIView alloc] init];
    underLine2View.backgroundColor = [UIColor grayColor];
    [self.basicScrollView addSubview:underLine2View];
    [underLine2View release];
    contentsHtmlY = currentY + kDetailViewUnderLineHeight;
    
    // コンテンツ
    currentY += kDetailViewUnderLineHeight + 20;
    contentsLabelY = currentY;
    contentsLabel = [[UILabel alloc] init];
    contentsWebView = [[UIWebView alloc] init];
    
    // プログレスダイアログ
    [self generateProgressDialog];
}

- (void)reloadMyViews
{
    // ビューの描画、整形
    
    contentsWebView.scalesPageToFit = YES;
    [self arrangeViews];
    [self loadTextContents];
    [self loadHtmlContents];
}

- (void)arrangeViews
{
    // ビュー（コンテンツ以外）の描画
    
    // アイコン
    iconImageView.frame = CGRectMake(kDetailViewHorizontalMargin, iconY, kDetailViewIconWidth, kDetailViewIconHeight);
    [iconImageView loadImageFromURL:[NSURL URLWithString:_message.piIconUrl]];
    
    // アプリ名
    float appliNameLabelX = kDetailViewHorizontalMargin + kDetailViewIconWidth + kDetailViewMarginBetweenIconAndAppliName;
    float appliNameLabelY = iconY + (kDetailViewIconHeight - kDetailViewAppliNameHeight) / 2;
    appliNameLabel.frame = CGRectMake(appliNameLabelX, appliNameLabelY, self.view.bounds.size.width - (appliNameLabelX + kDetailViewHorizontalMargin), kDetailViewAppliNameHeight);
    appliNameLabel.text = _message.piShop;
    
    // 区切り線1
    underLine1View.frame = CGRectMake(kDetailViewHorizontalMargin, underLine1Y, self.view.bounds.size.width - kDetailViewHorizontalMargin, kDetailViewUnderLineHeight);
    
    // タイトル
    titleLabel.frame = CGRectMake(kDetailViewHorizontalMargin, titleLabelY, self.view.bounds.size.width - (kDetailViewHorizontalMargin * 2), kDetailViewTitleHeight);
    titleLabel.text = _message.piTitle;
    
    // 区切り線2
    underLine2View.frame = CGRectMake(kDetailViewHorizontalMargin, underLine2Y, self.view.bounds.size.width - kDetailViewHorizontalMargin, kDetailViewUnderLineHeight);
}

- (void)loadTextContents
{
    // コンテンツの描画と整形（テキスト配信時）
    
    [contentsLabel removeFromSuperview];
    if ([_message.piContentType isEqualToString:@"text/html"]){
        return;
    }
    
    float totalHeight = contentsLabelY + 20;
    contentsLabel.frame = CGRectMake(kDetailViewHorizontalMargin, contentsLabelY, self.view.bounds.size.width - (kDetailViewHorizontalMargin * 2), self.view.frame.size.height);
    contentsLabel.numberOfLines = 0;
    contentsLabel.font = [UIFont systemFontOfSize:18];
    contentsLabel.textColor = [UIColor blackColor];
    contentsLabel.text = _message.piContent;
    [contentsLabel sizeToFit];
    if (![contentsLabel isDescendantOfView:self.basicScrollView]) {
        [self.basicScrollView addSubview:contentsLabel];
    }
    
    totalHeight += contentsLabel.frame.size.height;
    self.basicScrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalHeight);
    [self.basicScrollView setNeedsLayout];
    [self.basicScrollView setNeedsDisplay];
    [self.basicScrollView layoutIfNeeded];
}

- (void)loadHtmlContents
{
    // コンテンツの描画（HTML配信時）
    
    [contentsWebView removeFromSuperview];
    //contentsWebView.scalesPageToFit = YES;
    if (![_message.piContentType isEqualToString:@"text/html"]){
        return;
    }
    
    /*
     self.myWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
     self.myWebView.delegate = self;
    */
    
    contentsWebView.delegate = self;
    contentsWebView.dataDetectorTypes = UIDataDetectorTypeNone;
    contentsWebView.backgroundColor = [UIColor clearColor];
    contentsWebView.scalesPageToFit = YES;
    contentsWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    contentsWebView.delegate = self;
    contentsWebView.opaque = NO;
    if ([contentsWebView respondsToSelector:@selector(scrollView)]){
        contentsWebView.scrollView.scrollEnabled = YES;
        contentsWebView.scrollView.bounces = NO;
    } else {
        [[contentsWebView.subviews objectAtIndex:0] setScrollEnabled:YES];
        [[contentsWebView.subviews objectAtIndex:0] setBounces:NO];
    }
    contentsWebView.frame = CGRectMake(0, contentsHtmlY, self.view.frame.size.width, self.view.frame.size.height * 2);
    [contentsWebView loadHTMLString:_message.piContent baseURL:nil];
    
    [self arrangeHtmlContents];
}

- (void)arrangeHtmlContents
{
    // コンテンツの整形（HTML配信時）
    
    if (![_message.piContentType isEqualToString:@"text/html"]){
        return;
    }
    
    [self arrangeViews];
    
    if (![contentsWebView isDescendantOfView:self.basicScrollView]) {
        [self.basicScrollView addSubview:contentsWebView];
    }
    //[contentsWebView sizeToFit];
    
    float totalHeight = contentsHtmlY + contentsWebView.frame.size.height;
    self.basicScrollView.contentSize = CGSizeMake(self.view.frame.size.width, totalHeight);
    [self.basicScrollView setNeedsLayout];
    [self.basicScrollView setNeedsDisplay];
    [self.basicScrollView layoutIfNeeded];
}

#pragma mark - Progress Dialog

- (void)generateProgressDialog
{
    // プログレスダイアログの生成
    
    progressBackgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    progressBackgroundView.alpha = 20.0;
    progressBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    progressBackgroundView.hidden = YES;
    [self.view addSubview:progressBackgroundView];
    [progressBackgroundView release];
    
    progressBoxView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
    progressBoxView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
    progressBoxView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    progressBoxView.alpha = 50.0;
    progressBoxView.clipsToBounds = YES;
    progressBoxView.layer.cornerRadius = 5;
    progressBoxView.hidden = YES;
    [progressBackgroundView addSubview:progressBoxView];
    [progressBoxView release];
    
    progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 32, 230, 16)];
    progressLabel.text = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog4" value:@"お知らせを取得しています..." table:kLocalizableStrings];
    progressLabel.backgroundColor = [UIColor clearColor];
    progressLabel.textColor = [UIColor whiteColor];
    progressLabel.font = [UIFont boldSystemFontOfSize: 16];
    [progressBoxView addSubview:progressLabel];
    [progressLabel release];
    
    indicator =  [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    indicator.center = CGPointMake(25, progressBoxView.bounds.size.height / 2);
    [progressBoxView addSubview:indicator];
    [indicator release];
}

- (void)arrangeProgressDialog
{
    // プログレスダイアログの整形
    
    if (progressBackgroundView && progressBoxView && indicator) {
        progressBackgroundView.frame = self.view.bounds;
        progressBoxView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
        indicator.center = CGPointMake(25, progressBoxView.bounds.size.height / 2);
    }
}

- (void)setLoadingMode:(BOOL)isLoading
{
    progressBackgroundView.hidden = !isLoading;
    progressBoxView.hidden = !isLoading;
    if (isLoading) {
        [indicator startAnimating];
    } else {
        [indicator stopAnimating];
    }
}

#pragma mark - WebView Delegate（HTML配信時のみ）

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self setLoadingMode:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self setLoadingMode:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self arrangeHtmlContents];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *scheme = [[request URL] scheme];
    
    //contentsWebView.scalesPageToFit = YES;
    
    if ([scheme compare:@"about"] == NSOrderedSame) {
        // loadHTTPString で開いた場合
        [[UIApplication sharedApplication] openURL:[request URL]];
        return YES;
        
    } else {
        // リンクがクリックされたとき
        if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeOther) {
            // イベントトラッキング
            [[PopinfoEventTrackingController sharedEventTrackingController] trackEventOfLinkUrl:[[request URL] absoluteString] mid:super.messageId];
        }
    }
    
    if ([scheme compare:@"http"] == NSOrderedSame) {
        if ([request.URL.absoluteString isEqualToString:request.mainDocumentURL.absoluteString]) {
            // メインコンテンツの読込時のみ
            [[UIApplication sharedApplication] openURL:[request URL]];
            return NO;
        }
    }
    return YES;
}

#pragma mark - URLを開くボタンの動作

- (void)didSelectOpenUrl
{
    [super didSelectOpenUrl];
    
    // URLを開くボタンが押下された際に行いたい処理をここに記述（任意）
    
}

- (void)changeColorOfUrlButton
{
    // URLが空の場合はURLを開くボタンをグレーアウトさせる
    if (kIpadSplitViewUse && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 5.0f) {
        return;
    }
    if (_message.piUrl && [_message.piUrl length] == 0) {
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
        self.navigationItem.rightBarButtonItem.enabled = NO;
        //self.navigationItem.rightBarButtonItem = nil;
    }
}

#pragma mark - 通信エラー時のダイアログ

- (void)showNetworkErrorAlertView
{
    // 表示文字列生成
    NSString *title = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog5" value:@"Error" table:@"Localizable"];
    NSString *message = [[NSBundle mainBundle] localizedStringForKey:@"popinfoDialog6" value:@"通信に失敗しました。通信状況の良い場所でもう一度お試しください。" table:@"Localizable"];
    NSString *buttonTitle = [[NSBundle mainBundle] localizedStringForKey:@"popinfoButton3" value:@"閉じる" table:@"Localizable"];
    
    // アラートの表示
    if (NSClassFromString(@"UIAlertController")) {
        // iOS8
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        // iOS7以下
        UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:buttonTitle otherButtonTitles:nil] autorelease];
        [alertView show];
        
    }
}

#pragma mark - Message Update

- (void)popinfoMessageWillUpdate
{
    [super popinfoMessageWillUpdate];
    
    [self setLoadingMode:YES];
}

- (void)popinfoMessageDidUpdate
{
    [super popinfoMessageDidUpdate];
    
    [self setLoadingMode:NO];
    [self reloadMyViews];
    [self changeColorOfUrlButton];
}

#pragma mark - Rotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // iOS5以下の回転
    if (kIpadSplitViewUse && [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
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
    [self reloadMyViews];
    [self arrangeProgressDialog];
}

#pragma mark - SplitView（PopinfoPadViewControllerを利用する場合のみ）

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f) {
        barButtonItem.title = [[NSBundle mainBundle] localizedStringForKey:@"popinfoTitle1" value:@"お知らせ一覧" table:kLocalizableStrings];
        [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
        self.masterPopoverController = popoverController;
    }
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f) {
        [self.navigationItem setLeftBarButtonItem:nil animated:YES];
        self.masterPopoverController = nil;
    }
}

- (UISplitViewControllerDisplayMode)targetDisplayModeForActionInSplitViewController:(UISplitViewController *)svc
{
    // iOS8以上
    self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    return UISplitViewControllerDisplayModeAutomatic;
}

@end
