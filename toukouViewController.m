//
//  toukouViewController.m
//  coco
//
//  Created by yuki on 2013/04/02.
//  Copyright (c) 2013年 Yuki Moriya. All rights reserved.
//
#import "AppDelegate.h"
#import "toukouViewController.h"
//#import "GAI.h"
#import "GAI.h"
#import "GAITracker.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "STTwitter.h"
//テスト

@interface toukouViewController ()

@property NSArray *newsData;

@end

@implementation toukouViewController

@synthesize shopSearchNameMutableArray = _shopSearchNameMutableArray;
@synthesize shopSearchIdMutableArray = _shopSearchIdMutableArray;
@synthesize shopSearchContractMutableArray = _shopSearchContractMutableArray;
@synthesize kisyuSearchNameMutableArray = _kisyuSearchNameMutableArray;
@synthesize kisyuSearchIdMutableArray = _kisyuSearchIdMutableArray;
@synthesize kisyuSearchContractMutableArray = _kisyuSearchContractMutableArray;
@synthesize toukouTextStr = _toukouTextStr;
@synthesize postimg_thumb = _postimg_thumb;

#pragma mark - セットアップ
-(void)setup{
    selectPhotoFlag = 0;
    selectHoleFlag = 0;
    selectKisyuFlag = 0;
    
   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
       UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
       [headerView setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f]];
       [[self view] addSubview:headerView];
       
        if (screenSize.height == 568.0) {
            toukouView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, 640.0f, 548.0f)];
            [toukouView setBackgroundColor:[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.0f]];
            [[self view] addSubview:toukouView];
        }
        else{
            toukouView = [[UIView alloc] initWithFramfe:CGRectMake(0.0f, 20.0f, 640.0f, 460.0f)];
            [toukouView setBackgroundColor:[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.0f]];
            [[self view] addSubview:toukouView];
        }
    }
    else{
        if (screenSize.height == 568.0) {
            toukouView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 640.0f, 548.0f)];
            [toukouView setBackgroundColor:[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.0f]];
            [[self view] addSubview:toukouView];
        }
        else{
            toukouView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 640.0f, 460.0f)];
            [toukouView setBackgroundColor:[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.0f]];
            [[self view] addSubview:toukouView];
        }
    }
    
    
    
    toukouHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 50.0)];
    NSString *toukou_header_path = [[NSString alloc] init];
    toukou_header_path = [[NSBundle mainBundle] pathForResource:@"header_tokou2" ofType:@"png"];
    UIImage *backgroundHeaderImg = [[UIImage alloc] initWithContentsOfFile:toukou_header_path];
    toukouHeaderImgView.clipsToBounds = YES;
    toukouHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
    toukouHeaderImgView.image = backgroundHeaderImg;
    [toukouView addSubview:toukouHeaderImgView];
    
    backButton = [[tapArea alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 51.0f, 35.0f)];
    backButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *back_path = [[NSString alloc] init];
    back_path = [[NSBundle mainBundle] pathForResource:@"btn_back@2x" ofType:@"png"];
    [backButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:back_path] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:backButton];
    
    toukouButton = [[tapArea alloc] initWithFrame:CGRectMake(270.0f, 5.0f, 45.0f, 35.0f)];
    toukouButton.tappableInsets = UIEdgeInsetsMake(-10, -50, -10, -10);
    NSString *toukou_path = [[NSString alloc] init];
    toukou_path = [[NSBundle mainBundle] pathForResource:@"btn_send@2x" ofType:@"png"];
    [toukouButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:toukou_path] forState:UIControlStateNormal];
    [toukouButton addTarget:self action:@selector(postCheck) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:toukouButton];
    
    toukouTextView = [[UITextView alloc] initWithFrame:CGRectMake(10.0f, 60.0f, 300.0f, 100.0f)];
    [toukouTextView setDelegate:self];
    [toukouTextView setTextColor:[UIColor blackColor]];
    [toukouTextView setFont:[UIFont systemFontOfSize:16.0f]];
    [toukouView addSubview:toukouTextView];
    //[toukouTextView becomeFirstResponder];
    
    bannerView = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 165.0f, 300.0f, 40.0f)];
    [bannerView setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]];
    [toukouView addSubview:bannerView];
    
    
    bannerView2 = [[UIView alloc] initWithFrame:CGRectMake(10.0f, 210.5f, 300.0f, 40.0f)];
    [bannerView2 setBackgroundColor:[UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f]];
    [toukouView addSubview:bannerView2];

    
    cameraButton = [[tapArea alloc] initWithFrame:CGRectMake(15.0f, 173.0f, 30.5f, 23.5f)];
    cameraButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -50, -10);
    NSString *camera_path = [[NSString alloc] init];
    camera_path = [[NSBundle mainBundle] pathForResource:@"icon_camera@2x" ofType:@"png"];
    [cameraButton setImage:[[UIImage alloc] initWithContentsOfFile:camera_path] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(openAs) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:cameraButton];
    
    checkinButton = [[tapArea alloc] initWithFrame:CGRectMake(61.5f, 171.5f, 17.0f, 27.0f)];
    checkinButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -300);
    NSString *checkin_path = [[NSString alloc] init];
    checkin_path = [[NSBundle mainBundle] pathForResource:@"icon_location@2x" ofType:@"png"];
    [checkinButton setImage:[[UIImage alloc] initWithContentsOfFile:checkin_path] forState:UIControlStateNormal];
    [checkinButton addTarget:self action:@selector(searchshopopen) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:checkinButton];
    
    kisyuButton = [[tapArea alloc] initWithFrame:CGRectMake(15.0f, 218.0f, 27.0f, 27.0f)];
    kisyuButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -50, -300);
    NSString *kisyu_path = [[NSString alloc] init];
    kisyu_path = [[NSBundle mainBundle] pathForResource:@"flag1@2x" ofType:@"png"];
    [kisyuButton setImage:[[UIImage alloc] initWithContentsOfFile:kisyu_path] forState:UIControlStateNormal];
    [kisyuButton addTarget:self action:@selector(searchkisyuopen) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:kisyuButton];
    
    bannerWebView1 = [[UIWebView alloc] initWithFrame:CGRectMake(10.0f, 260.0f, 300.0f, 250.0f)];
    bannerWebView1.scalesPageToFit = YES;
    bannerWebView1.delegate = self;
    bannerWebView1.scrollView.scrollEnabled = NO;
    bannerWebView1.scrollView.delegate = self;
    [toukouView addSubview:bannerWebView1];
    NSURL *url  = [NSURL URLWithString:[NSString stringWithFormat:@"http://cocopachi.com/apps/ios/banner_tu.php?user_id=%d",user_id]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    
    
    [bannerWebView1 loadRequest:request];
    
    //非表示にするならこれ
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *chutoriaru = [defaults stringForKey:@"chutoriaru"];
    if([chutoriaru isEqual:@"off"]){
        bannerWebView1.hidden = YES;
    }
        
    shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 171.0f, 190.0f, 30.0f)];
    [shopNameLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
    [shopNameLabel setTextColor:[UIColor blackColor]];
    [shopNameLabel setFont:[UIFont fontWithName:@"HiraMinProN-W3" size:16.0f]];
    [shopNameLabel setText:[NSString stringWithFormat:@"店舗を選んでください"]];
    [toukouView addSubview:shopNameLabel];
    
    kisyuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 217.0f, 190.0f, 30.0f)];
    [kisyuNameLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
    [kisyuNameLabel setTextColor:[UIColor blackColor]];
    [kisyuNameLabel setFont:[UIFont fontWithName:@"HiraMinProN-W3" size:16.0f]];
    [kisyuNameLabel setText:[NSString stringWithFormat:@"機種を選んでください"]];
    [toukouView addSubview:kisyuNameLabel];
    
    charCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(280.0f, 171.0f, 30.0f, 30.0f)];
    [charCountLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
    [charCountLabel setTextColor:[UIColor blackColor]];
    [charCountLabel setFont:[UIFont fontWithName:@"HiraMinProN-W3" size:18.0f]];
    [charCountLabel setText:[NSString stringWithFormat:@"60"]];
    [toukouView addSubview:charCountLabel];
    
    selectkisyu = 0;
    
    /*
    shopHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 50.0)];
    NSString *shop_header_path = [[NSString alloc] init];
    shop_header_path = [[NSBundle mainBundle] pathForResource:@"header_seach2" ofType:@"png"];
    UIImage *backgroundHeadershopImg = [[UIImage alloc] initWithContentsOfFile:shop_header_path];
    shopHeaderImgView.clipsToBounds = YES;
    shopHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
    shopHeaderImgView.image = backgroundHeadershopImg;
    [toukouView addSubview:shopHeaderImgView];
    */
    
    /*
    kisyuHeaderImgview = [[UIImageView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 50.0)];
    NSString *kisyu_header_path = [[NSString alloc] init];
    kisyu_header_path = [[NSBundle mainBundle] pathForResource:@"header_kisyu" ofType:@"png"];
    UIImage *backgroundHeaderkisyuImg = [[UIImage alloc] initWithContentsOfFile:kisyu_header_path];
    shopHeaderImgView.clipsToBounds = YES;
    shopHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
    shopHeaderImgView.image = backgroundHeaderkisyuImg;
    [toukouView addSubview:kisyuHeaderImgview];
    */
     
    /*
    shopSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(320.0f, 50.0f, 320.0f, 50.0f)];
    [shopSearchBar setDelegate:self];
    shopSearchBar.showsCancelButton = NO;
    [shopSearchBar setPlaceholder:@"店舗検索"];
    [shopSearchBar setBarStyle:UIBarStyleBlack];
    [toukouView addSubview:shopSearchBar];
    */
    
    /*
    kisyuSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(320.0f, 50.0f, 320.0f, 50.0f)];
    [kisyuSearchBar setDelegate:self];
    kisyuSearchBar.showsCancelButton = NO;
    [kisyuSearchBar setPlaceholder:@"機種選択"];
    [kisyuSearchBar setBarStyle:UIBarStyleBlack];
    [toukouView addSubview:kisyuSearchBar];
    */
    
    /*
    shopBackButton = [[tapArea alloc] initWithFrame:CGRectMake(325.0f, 5.0f, 51.0f, 35.0f)];
    shopBackButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *shopback_path = [[NSString alloc] init];
    shopback_path = [[NSBundle mainBundle] pathForResource:@"btn_back@2x" ofType:@"png"];
    [shopBackButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:shopback_path] forState:UIControlStateNormal];
    [shopBackButton addTarget:self action:@selector(serchShopClose) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:shopBackButton];
    */
     
    [self openAs];
}
#pragma mark - twitterAlert
-(void)twAlert{
    twAlertView = [[UIAlertView alloc] initWithTitle:@"投稿します" message:[NSString stringWithFormat:@"twitterにも投稿しますか？"]
                                                delegate:self cancelButtonTitle:@"いいえ"
                                       otherButtonTitles:@"はい", nil];
    [twAlertView show];
}

-(void)postCheck{
    postCheckView = [[UIAlertView alloc] initWithTitle:@"投稿" message:[NSString stringWithFormat:@"この内容で投稿しますか？"]
                                            delegate:self cancelButtonTitle:@"いいえ"
                                   otherButtonTitles:@"はい", nil];
    [postCheckView show];
}

#pragma mark - アラートボタン押した時
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == postCheckView) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"ぜろ");
                twFlag = 0;
                //[self toPost];
                //[self twJudge];
                break;
                
            case 1:
                NSLog(@"いち");
                twFlag = 0;
                //[self twJudge];
                [self toPost];
                break;
        }
    }
    else{
        switch (buttonIndex) {
            case 0:
                NSLog(@"ぜろ");
                //twFlag = 0;
                //[self toPost];
                //[self twJudge];
                break;
                
            case 1:
                NSLog(@"いち");
                twFlag = 1;
                [self goTwitter];
                //[self toPost];
                break;
        }
    }
}


-(void)twJudge{
    [self goTwitter];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *twaccesstaken = [defaults stringForKey:@"twaccesstaken"];
    NSString *twaccesstakensecret = [defaults stringForKey:@"twaccesstakensecret"];
    
    /*
    NSLog(@"どうでしょう？(twaccesstaken)→%@",twaccesstaken);
    NSLog(@"どうでしょう？(twaccesstakensecret)→%@",twaccesstakensecret);
    */
    //NSLog(@"とーくん→%@",accessToken);
    //NSLog(@"しーくれっと→%@",accessTokenSecret);
     
    int accesstakenCount = (int)[twaccesstaken length];
    int secretCount = (int)[twaccesstakensecret length];
    
    
    if (accesstakenCount>0 && secretCount>0) {
        [self toPost];
    }
    else{
        twFlag = 0;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ツイッターの連携を許可してください" message:@"ツイッターにも同時に投稿するためには、ココ！ぱちとツイッターの連携を許可する必要があります。「設定」→「Twiiter」→「アカウントの仕様を許可するAPP」から、ココ！ぱちを「オン」にして、アプリを再起動してください。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark テキストフィールド
/*- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    self.toukouTextStr = [[NSString alloc] init];
    self.toukouTextStr = textView.text;
    
    NSLog(@"何書いてるの？%@",self.toukouTextStr);
    return YES;
}
*/

/*
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    // キーボードの非表示.
    [self.view endEditing:YES];
    // 改行しない.
    return NO;
}
*/

- (void)textViewDidChange:(UITextView *)textView{
    self.toukouTextStr = [[NSString alloc] init];
    self.toukouTextStr = textView.text;
    charCount = (int)[self.toukouTextStr length];
    //if (60 - (int)[self.toukouTextStr length]>0) {
        charCountLabel.text = [NSString stringWithFormat:@"%d",60-(int)[self.toukouTextStr length]];
    //}
    //else{
      //  charCountLabel.text = @"0";
    //}
    
    
    if ([self.toukouTextStr length]>55) {
        charCountLabel.textColor = [UIColor redColor];
    }
    else{
        charCountLabel.textColor = [UIColor blackColor];
    }
    
    NSLog(@"eee:%@",self.toukouTextStr);
}

#pragma mark - お店探す
-(void)searchshopopen{
    selecthole = 1;
    
    //各オブジェクト設置
    shopHeaderImgView = [[UIImageView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 50.0)];
    NSString *shop_header_path = [[NSString alloc] init];
    shop_header_path = [[NSBundle mainBundle] pathForResource:@"header_seach2" ofType:@"png"];
    UIImage *backgroundHeadershopImg = [[UIImage alloc] initWithContentsOfFile:shop_header_path];
    shopHeaderImgView.clipsToBounds = YES;
    shopHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
    shopHeaderImgView.image = backgroundHeadershopImg;
    [toukouView addSubview:shopHeaderImgView];
    
    shopSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(320.0f, 50.0f, 320.0f, 50.0f)];
    [shopSearchBar setDelegate:self];
    shopSearchBar.showsCancelButton = NO;
    [shopSearchBar setPlaceholder:@"店舗検索"];
    [shopSearchBar setBarStyle:UIBarStyleBlack];
    [toukouView addSubview:shopSearchBar];
    
    shopBackButton = [[tapArea alloc] initWithFrame:CGRectMake(325.0f, 5.0f, 51.0f, 35.0f)];
    shopBackButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *shopback_path = [[NSString alloc] init];
    shopback_path = [[NSBundle mainBundle] pathForResource:@"btn_back@2x" ofType:@"png"];
    [shopBackButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:shopback_path] forState:UIControlStateNormal];
    [shopBackButton addTarget:self action:@selector(serchShopClose) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:shopBackButton];
    
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //[UIView setAnimationDidStopSelector:@selector(pullHelp)];
    toukouView.frame = CGRectOffset(toukouView.frame, -320.0f, 0);
    [UIView commitAnimations];
    
    [self.shopSearchNameMutableArray removeAllObjects];
    [self.shopSearchIdMutableArray removeAllObjects];
    [self.shopSearchContractMutableArray removeAllObjects];
    
    [toukouTextView resignFirstResponder];
    

    NSURL *url = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/nearshop2.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"user_id=%d&latitude=%f&longitude=%f",user_id,_latitude,_longitude];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    shopsearchConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    /*機種サーチデータチェック*/
    /*
    NSURL *kisyuUrl = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/kisyuget.php"];
    NSMutableURLRequest *request_kisyu = [[NSMutableURLRequest alloc] initWithURL:kisyuUrl];
    request.HTTPMethod = @"POST";
    NSString *body_kisyu = [NSString stringWithFormat:@"user_id=%d",user_id];
    request.HTTPBody = [body_kisyu dataUsingEncoding:NSUTF8StringEncoding];
    kisyusearchConnection = [[NSURLConnection alloc] initWithRequest:request_kisyu delegate:self];
    */
    
    if (!shopsearchConnection) {
        NSLog(@"通信してません");
    }
    else{
        [self netAccessSrart];
    }
}

#pragma mark - 機種探す
-(void)searchkisyuopen{
    //kisyusearchTableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    
    kisyuHeaderImgview = [[UIImageView alloc] initWithFrame:CGRectMake(320.0f, 0.0f, 320.0f, 50.0)];
    NSString *kisyu_header_path = [[NSString alloc] init];
    kisyu_header_path = [[NSBundle mainBundle] pathForResource:@"header_kisyu" ofType:@"png"];
    UIImage *backgroundHeaderkisyuImg = [[UIImage alloc] initWithContentsOfFile:kisyu_header_path];
    shopHeaderImgView.clipsToBounds = YES;
    shopHeaderImgView.contentMode = UIViewContentModeScaleAspectFill;
    shopHeaderImgView.image = backgroundHeaderkisyuImg;
    [toukouView addSubview:kisyuHeaderImgview];
    
    kisyuSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(320.0f, 50.0f, 320.0f, 50.0f)];
    [kisyuSearchBar setDelegate:self];
    kisyuSearchBar.showsCancelButton = NO;
    [kisyuSearchBar setPlaceholder:@"機種選択"];
    [kisyuSearchBar setBarStyle:UIBarStyleBlack];
    [toukouView addSubview:kisyuSearchBar];
    
    shopBackButton = [[tapArea alloc] initWithFrame:CGRectMake(325.0f, 5.0f, 51.0f, 35.0f)];
    shopBackButton.tappableInsets = UIEdgeInsetsMake(-10, -10, -10, -50);
    NSString *shopback_path = [[NSString alloc] init];
    shopback_path = [[NSBundle mainBundle] pathForResource:@"btn_back@2x" ofType:@"png"];
    [shopBackButton setBackgroundImage:[[UIImage alloc] initWithContentsOfFile:shopback_path] forState:UIControlStateNormal];
    [shopBackButton addTarget:self action:@selector(kisyuShopClose) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:shopBackButton];
    
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //[UIView setAnimationDidStopSelector:@selector(pullHelp)];
    toukouView.frame = CGRectOffset(toukouView.frame, -320.0f, 0);
    [UIView commitAnimations];
    
    [self.kisyuSearchNameMutableArray removeAllObjects];
    [self.kisyuSearchIdMutableArray removeAllObjects];
    [self.kisyuSearchContractMutableArray removeAllObjects];
    
    [toukouTextView resignFirstResponder];
     
    /*機種サーチデータチェック*/
    NSLog(@"機種のここ通ってるまる");
    
    if(selectkisyu == 0){
        NSURL *kisyuUrl = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/kisyu_def.php"];
        NSMutableURLRequest *request_kisyu = [[NSMutableURLRequest alloc] initWithURL:kisyuUrl];
        request_kisyu.HTTPMethod = @"POST";
        NSString *body_kisyu = [NSString stringWithFormat:@"user_id=%d",user_id];
        request_kisyu.HTTPBody = [body_kisyu dataUsingEncoding:NSUTF8StringEncoding];
        kisyusearchConnection = [[NSURLConnection alloc] initWithRequest:request_kisyu delegate:self];
    
        selectkisyu = selectkisyu + 1;
    }
    
    /*
    defKisyu = @"ばじ";
    NSURL *url = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/kisyuget.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"user_id=%d&word=%@",user_id,defKisyu];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    kisyusearchConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    */
    
    if (!kisyusearchConnection) {
        NSLog(@"通信してません");
    }
    else{
        [self netAccessSrart];
    }
}
-(void)serchShopClose{
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //[UIView setAnimationDidStopSelector:@selector(pullHelp)];
    toukouView.frame = CGRectOffset(toukouView.frame, 320.0f, 0);
    [UIView commitAnimations];
    
    //[toukouTextView becomeFirstResponder];
    
    [shopNameLabel setText:shopName];
    //kisyuNameLabel
    //[kisyuNameLabel setText:shopName];
    
    if (selectHoleFlag == 1) {
        NSString *checkin_path = [[NSString alloc] init];
        checkin_path = [[NSBundle mainBundle] pathForResource:@"icon_location_on@2x" ofType:@"png"];
        [checkinButton setImage:[[UIImage alloc] initWithContentsOfFile:checkin_path] forState:UIControlStateNormal];
    }
    else{
        shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 171.0f, 190.0f, 30.0f)];
        [shopNameLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
        [shopNameLabel setTextColor:[UIColor blackColor]];
        [shopNameLabel setFont:[UIFont fontWithName:@"HiraMinProN-W3" size:16.0f]];
        [shopNameLabel setText:[NSString stringWithFormat:@"店舗を選んでください"]];
        [toukouView addSubview:shopNameLabel];
    }
    selecthole = 0;
}

-(void)kisyuShopClose{
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    //[UIView setAnimationDidStopSelector:@selector(pullHelp)];
    toukouView.frame = CGRectOffset(toukouView.frame, 320.0f, 0);
    [UIView commitAnimations];
    
    //kisyusearchTableView = NULL;
    
    
    //[toukouTextView becomeFirstResponder];
    
    [kisyuNameLabel setText:kisyuName];
    //kisyuNameLabel
    
    if(selectKisyuFlag == 1){
        NSString *kisyu_path = [[NSString alloc] init];
        kisyu_path = [[NSBundle mainBundle] pathForResource:@"flag2@2x" ofType:@"png"];
        [kisyuButton setImage:[[UIImage alloc] initWithContentsOfFile:kisyu_path] forState:UIControlStateNormal];
    }
    else{
        kisyuNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 217.0f, 190.0f, 30.0f)];
        [kisyuNameLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
        [kisyuNameLabel setTextColor:[UIColor blackColor]];
        [kisyuNameLabel setFont:[UIFont fontWithName:@"HiraMinProN-W3" size:16.0f]];
        [kisyuNameLabel setText:[NSString stringWithFormat:@"機種を選んでください"]];
        [toukouView addSubview:kisyuNameLabel];
    }
    selectkisyu = 0;
}

#pragma mark ショップ名前検索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [shopSearchBar resignFirstResponder];
    
    if(selecthole == 1){
        [self.shopSearchNameMutableArray removeAllObjects];
        [self.shopSearchIdMutableArray removeAllObjects];
        [self.shopSearchContractMutableArray removeAllObjects];
    
        NSString *searchShopStr = shopSearchBar.text;
    
        NSURL *url = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/nearshop2.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSString *body = [NSString stringWithFormat:@"user_id=%d&word=%@",user_id,searchShopStr];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        shopsearchConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [searchBar resignFirstResponder];
    }
    else if(selectkisyu == 1){
        [self.kisyuSearchNameMutableArray removeAllObjects];
        [self.kisyuSearchIdMutableArray removeAllObjects];
        [self.kisyuSearchContractMutableArray removeAllObjects];
        
        NSString *searchKisyuStr = kisyuSearchBar.text;
        
        NSURL *url = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/kisyuget.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        NSString *body = [NSString stringWithFormat:@"user_id=%d&word=%@",user_id,searchKisyuStr];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        kisyusearchConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        [searchBar resignFirstResponder];
        kensakunum = kensakunum + 1;
    }
    if (!shopsearchConnection) {
        NSLog(@"通信してません");
    }
    else if(!kisyusearchConnection){
        NSLog(@"通信していません");
    }
    else{
        [self netAccessSrart];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == shopsearchTableView) {
        return  shopSearchCount;
    }
    else if(tableView == kisyusearchTableView){
        return kisyuSearchCount;
    }
    return NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (tableView == shopsearchTableView) {

        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        if(indexPath.section == 0) {
            if (shopSearchCount > 0) {
                for (int i = 0; i<shopSearchCount; i++) {
                    if (indexPath.row == i) {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.shopSearchNameMutableArray objectAtIndex:i]];
                        cell.textLabel.textColor = [UIColor blackColor];
                        if ([[self.shopSearchContractMutableArray objectAtIndex:i] isEqualToString:@"1"]) {
                            cell.textLabel.textColor = [UIColor redColor];
                        }
                    }
                }
            }
        }
        return cell;
    }
    else if(tableView == kisyusearchTableView){
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        if(indexPath.section == 0) {
            if (kisyuSearchCount > 0) {
                for (int i = 0; i<kisyuSearchCount; i++) {
                    if (indexPath.row == i) {
                        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.kisyuSearchNameMutableArray objectAtIndex:i]];
                        cell.textLabel.textColor = [UIColor blackColor];
                    }
                }
            }
        }
        return cell;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == shopsearchTableView) {
        [shopsearchTableView deselectRowAtIndexPath:indexPath animated:YES];
        shopSearchIdInt = [shopSearchId[indexPath.row] intValue];
        shopName = shopSearchName[indexPath.row];
        NSLog(@"ホールID%d",shopSearchIdInt);
        
        selectHoleFlag = 1;
        [self serchShopClose];
    }
    else if (tableView == kisyusearchTableView) {
        [kisyusearchTableView deselectRowAtIndexPath:indexPath animated:YES];
        kisyuSearchIdInt = [kisyuSearchId[indexPath.row] intValue];
        kisyuName = kisyuSearchName[indexPath.row];
        NSLog(@"機種ID%d",kisyuSearchIdInt);
        
        selectKisyuFlag = 1;
        [self kisyuShopClose];
    }
}

#pragma mark ショップ表示
-(void)writeShopsearch{
    if (screenSize.height == 568.0f) {
        shopsearchTableView = [[UITableView alloc] initWithFrame:CGRectMake(320.0f, 100.0f, 320.0f, 468.0f) style:UITableViewStylePlain];
        [shopsearchTableView setDataSource:self];
        [shopsearchTableView setDelegate:self];
        [toukouView addSubview:shopsearchTableView];
    }
    else{
        shopsearchTableView = [[UITableView alloc] initWithFrame:CGRectMake(320.0f, 100.0f, 320.0f, 360.0f) style:UITableViewStylePlain];
        [shopsearchTableView setDataSource:self];
        [shopsearchTableView setDelegate:self];
        [toukouView addSubview:shopsearchTableView];
    }
}

#pragma mark 機種表示
-(void)writeKisyusearch{
    if (screenSize.height == 568.0f) {
        kisyusearchTableView = [[UITableView alloc] initWithFrame:CGRectMake(320.0f, 100.0f, 320.0f, 468.0f) style:UITableViewStylePlain];
        [kisyusearchTableView setDataSource:self];
        [kisyusearchTableView setDelegate:self];
        [toukouView addSubview:kisyusearchTableView];
    }
    else{
        kisyusearchTableView = [[UITableView alloc] initWithFrame:CGRectMake(320.0f, 100.0f, 320.0f, 360.0f) style:UITableViewStylePlain];
        [kisyusearchTableView setDataSource:self];
        [kisyusearchTableView setDelegate:self];
        [toukouView addSubview:kisyusearchTableView];
    }
}

#pragma mark - Topページへ
-(void)toTop{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 投稿
-(void)toPost{
    if (selectPhotoFlag == 0) {
        UIAlertView *postAlert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"投稿画像を選択してください"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(performDismiss:) userInfo:postAlert repeats:NO];
        [postAlert show];
    }
    else{
        if (selectHoleFlag == 0) {
            UIAlertView *postAlert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"ホールを選択してください"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(performDismiss:) userInfo:postAlert repeats:NO];
            [postAlert show];
        }
        else{
            if (charCount > 60) {
                UIAlertView *postAlert = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"60文字までしか投稿できません"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [NSTimer scheduledTimerWithTimeInterval:0.6f target:self selector:@selector(performDismiss:) userInfo:postAlert repeats:NO];
                [postAlert show];
            }
            else{
                NSLog(@"機種IDこれだよ→%d",kisyuSearchIdInt);
                NSURL *url = [NSURL URLWithString:@"http://cocopachi.com/apps/ios/post.php"];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
                request.HTTPMethod = @"POST";
                NSString *body = [NSString stringWithFormat:@"user_id=%d&shop_id=%d&body=%@&photo_flag=%d&twflag=%d&kisyu=%d",user_id,shopSearchIdInt,self.toukouTextStr,ipcFlag,twFlag,kisyuSearchIdInt];
                request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
                postConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
                if (!postConnection) {
                    NSLog(@"通信してません");
                }
                else{
                    [self netAccessSrart];
                }
            }
        }
    }
}
#pragma mark 自動アラート消し
-(void)performDismiss:(NSTimer *)theTimer{
    UIAlertView *postAlert = [theTimer userInfo];
    [postAlert dismissWithClickedButtonIndex:0 animated:NO];
}


-(UIImage*)uiImageFromCIImage:(CIImage*)ciImage
{
    CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @NO }];
    CGImageRef imgRef = [ciContext createCGImage:ciImage fromRect:[ciImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:imgRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(imgRef);
    return newImg;
    
    /* iOS6.0以降だと以下が使用可能 */
    // [[UIImage alloc] initWithCIImage:ciImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}

#pragma mark 画像アップデート
-(void)toukouImgUpdata{
    [self netAccessSrart];
    NSString *url = @"http://cocopachi.com/apps/ios/post_img.php/";
    NSMutableURLRequest *requesturl = [[NSMutableURLRequest alloc] init ];
    [requesturl setURL:[NSURL URLWithString:url]];
    [requesturl setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [requesturl addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    /*CGSize bigsz = CGSizeMake(postimg.size.width*0.5, postimg.size.height*0.5);
    UIGraphicsBeginImageContext(bigsz);
    [postimg drawInRect:CGRectMake(0.0f, 0.0f, bigsz.width, bigsz.height)];
    NSLog(@"リサイズ後横%f",bigsz.width);
    NSLog(@"リサイズ後縦%f",bigsz.height);
    postimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();*/
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:postimg];
    // リサイズする倍率を求める
    
    CGFloat scale = postimg.size.width < postimg.size.height ? 300/postimg.size.height : 300/postimg.size.width;
    // CGAffineTransformでサイズ変更
    CIImage *filteredImage = [ciImage imageByApplyingTransform:CGAffineTransformMakeScale(scale,scale)];
    // UIImageに変換
    UIImage *newImg = [self uiImageFromCIImage:filteredImage];
    
    
    NSData *imageDatas = UIImageJPEGRepresentation(newImg,1.0);
    
    int length = [imageDatas length];
    
    NSLog(@"容量%d",length);
    
    NSData *imageData;
    
    if (length>200000) {
        imageData = UIImageJPEGRepresentation(newImg,0.1);
    }
    else if (length>100000) {
        imageData = UIImageJPEGRepresentation(newImg,0.3);
    }
    else if (length>50000) {
        imageData = UIImageJPEGRepresentation(newImg,0.5);
    }
    else{
        imageData = UIImageJPEGRepresentation(newImg,1.0);
    }

    
    //[body appendData:[[NSString stringWithFormat:@"hashimei=%@",uuid] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"profimg\"; filename=\"%d.jpg\"\r\n ",toukouId] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type:image/%d.jpg\r\n\r\n",toukouId ] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    
    [requesturl setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:requesturl returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"画像帰ってきた文字列%@", returnString);
    
    //NSString *imgName = [NSString stringWithFormat:@"%@.jpg",idStr];
    int returnInt = [returnString length];
    if(returnInt > 0){
        bigFlag = 1;
        [self netAccessEnd];
        [self imgCheck];
    }
}

-(void)toukouImgThumbUpdata{
    [self netAccessSrart];
    NSString *url = @"http://cocopachi.com/apps/ios/post_imgthumb.php/";
    NSMutableURLRequest *requesturl = [[NSMutableURLRequest alloc] init ];
    [requesturl setURL:[NSURL URLWithString:url]];
    [requesturl setHTTPMethod:@"POST"];
    
    NSMutableData *body = [NSMutableData data];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;boundary=%@",boundary];
    [requesturl addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    NSData *imageData = UIImageJPEGRepresentation(self.postimg_thumb,0.4);
    //[body appendData:[[NSString stringWithFormat:@"hashimei=%@",uuid] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: attachment; name=\"profimg\"; filename=\"%d.jpg\"\r\n ",toukouId] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type:image/%d.jpg\r\n\r\n",toukouId ] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary]dataUsingEncoding:NSUTF8StringEncoding]];
    
    [requesturl setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:requesturl returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"画像帰ってきた文字列%@", returnString);
    
    //NSString *imgName = [NSString stringWithFormat:@"%@.jpg",idStr];
    int returnInt = [returnString length];
    if(returnInt > 0){
        thumbFlag = 1;
        [self netAccessEnd];
        [self imgCheck];
    }
}
-(void)imgCheck{
    if (bigFlag == 1 && thumbFlag == 1) {
        [self postDone];
    }
}

#pragma mark - カメラ選択
-(void)openAs{
    [toukouTextView resignFirstResponder];
    UIActionSheet *as = [[UIActionSheet alloc] init];
    as.delegate = self;
    as.title = @"選択してください。";
    [as addButtonWithTitle:@"カメラを起動する"];
    [as addButtonWithTitle:@"写真を選ぶ"];
    [as addButtonWithTitle:@"キャンセル"];
    as.cancelButtonIndex = 2;
    as.destructiveButtonIndex = 2;
    [as showInView:self.view.window];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    ipcFlag = 0;
    switch (buttonIndex) {
        case 0:
            NSLog(@"カメラ");
            [toukouTextView resignFirstResponder];
            ipcFlag = 1;
            [self imgup];
            break;
            
        case 1:
            NSLog(@"ギャラリー");
            [toukouTextView resignFirstResponder];
            ipcFlag = 2;
            [self imgup];
            break;
            
        case 2:
            NSLog(@"キャンセル");
            //[toukouTextView becomeFirstResponder];
            break;
            
        default:
            break;
    } 
}

-(void)imgup{
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    if (status == ALAuthorizationStatusNotDetermined){
        NSLog(@"まだ許可ダイアログ出たことない");
        ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        if (ipcFlag == 1) {
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        ipc.allowsEditing = YES;
        [self presentViewController:ipc animated:YES completion:nil];
    } else if (status == ALAuthorizationStatusRestricted){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"機能制限を解除してください" message:@"カメラロールの画像を選択するためには、機能制限を解除する必要があります。「設定」→「一般」→「機能制限」→「プライバシー」→「写真」から、ココ！ぱちを「オン」にする必要があります。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if (status == ALAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"プライバシー設定をオンにしてください" message:@"カメラロールの画像を選択するためには、プライバシー設定をオンにする必要があります。「設定」→「プライバシー」→「写真」から、ココ！ぱちを「オン」にする必要があります。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if (status == ALAuthorizationStatusAuthorized){
        NSLog(@"写真へのアクセスが許可されています");
        ipc = [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        if (ipcFlag == 1) {
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        ipc.allowsEditing = YES;
        //[[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self presentViewController:ipc animated:YES completion:nil];
    }
}

#pragma mark 画像選択時
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    [cameraButton removeFromSuperview];
    [cameraImgView removeFromSuperview];
    [coverButton removeFromSuperview];
    
    [toukouTextView becomeFirstResponder];
    
    [self dismissModalViewControllerAnimated:YES];
    UIImage* imageOriginal = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
    UIGraphicsBeginImageContext(imageOriginal.size);
    [imageOriginal drawInRect:CGRectMake(0, 0, imageOriginal.size.width, imageOriginal.size.height)];
    imageOriginal = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect cropRect;
    [[editingInfo objectForKey:UIImagePickerControllerCropRect] getValue:&cropRect];
    imageRef = CGImageCreateWithImageInRect(imageOriginal.CGImage, cropRect);
    postimg =[UIImage imageWithCGImage:imageRef];
    
    float width_per = 0.1;
    float height_per = 0.1;
    
    CGSize sz = CGSizeMake(postimg.size.width*width_per, postimg.size.height*height_per);
    UIGraphicsBeginImageContext(sz);
    [postimg drawInRect:CGRectMake(0.0f, 0.0f, sz.width, sz.height)];
    NSLog(@"画像選択後横%f",sz.width);
    NSLog(@"画像選択後縦%f",sz.height);
    self.postimg_thumb = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //UIImageWriteToSavedPhotosAlbum(postimg_thumb, self, @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:), nil);
    
    cameraImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0f, 165.0f, 40.0f, 40.0f)];
    cameraImgView.clipsToBounds = YES;
    cameraImgView.contentMode = UIViewContentModeScaleAspectFill;
    cameraImgView.image = postimg;
    [toukouView addSubview:cameraImgView];
    
    coverButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    coverButton.frame = CGRectMake(10.0f, 165.0f, 40.0f, 40.0f);
    [coverButton setAlpha:0.1f];
    [coverButton addTarget:self action:@selector(openAs) forControlEvents:UIControlEventTouchUpInside];
    [toukouView addSubview:coverButton];
    
    selectPhotoFlag = 1;
}

#pragma mark 画像選択キャンセル時
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
    //[toukouTextView becomeFirstResponder];
}

#pragma mark - 投稿完了
-(void)postDone{
    [toukouTextView resignFirstResponder];
    
    doneView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, screenSize.height-20)];
    [[self view] addSubview:doneView];
    
    doneWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, screenSize.height-70)];
    doneWebView.scalesPageToFit = YES;
    doneWebView.delegate = self;
    [doneView addSubview:doneWebView];
    NSURL *url  = [NSURL URLWithString:[NSString stringWithFormat:@"http://cocopachi.com/apps/web/kanryo.php?os=1"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url];
    [doneWebView loadRequest:request];
    
    NSString *close_path = [[NSString alloc] init];
    close_path = [[NSBundle mainBundle] pathForResource:@"doneclose" ofType:@"png"];
    doneCloseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, screenSize.height-70, 320, 50)];
    [doneCloseButton setImage:[[UIImage alloc] initWithContentsOfFile:close_path] forState:UIControlStateNormal];
    [doneCloseButton addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    [doneView addSubview:doneCloseButton];
    
    selectkisyu = 0;
    
    //kensakunum = 0;
    
    [self twAlert];
    
    
    AppAdForceLtv *ltv = [[[AppAdForceLtv alloc] init] autorelease];
    [ltv sendLtv:8144];
    
}

#pragma mark - ツイッターへのweb
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //NSString *chutoriaru_link = [defaults stringForKey:@"chutoriaru_link"];
    NSLog(@"リクエストは？？%@",requestString);
    if ([requestString hasPrefix:@"gotwitter://"]) {
        NSLog(@"ツイッター");
        [self goTwitter];
        return NO;
    }
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked ) {
        //if([chutoriaru_link isEqual:@"off"]){
            [[UIApplication sharedApplication] openURL: [request URL]];
            return NO;
        //}
    }
    //NSLog(@"ここ通ってるよ");
    
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [doneWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout = 'none';"];
}

#pragma mark ツイッターのAPI
-(void)goTwitter{
    //NSLog(@"ついったーAPI");
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) { //利用可能チェック
        NSString *serviceType = SLServiceTypeTwitter;
        SLComposeViewController *composeCtl = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [composeCtl setInitialText:[NSString stringWithFormat:@"%@ %@",self.toukouTextStr,@"#ココぱち"]];
        [composeCtl addImage:postimg];
        [composeCtl setCompletionHandler:^(SLComposeViewControllerResult result) {
            if (result == SLComposeViewControllerResultDone) {
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
        }];
        [self presentViewController:composeCtl animated:YES completion:nil];
    }
    /*
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [store requestAccessToAccountsWithType:twitterType
                     withCompletionHandler:^(BOOL granted, NSError *error) {
                         if (granted) {
                             //アクセスが許可されたときの処理
                             NSLog(@"許可");
                             //設定されているアカウントを取得
                             //self.twitterAccounts = [store accountsWithAccountType:twitterType];
                         }else {
                             //アクセスが拒否されたときの処理
                             NSLog(@"拒否");
                         }
                     }];
    */
}


#pragma mark - ネットアクセス
-(void)netAccessSrart{
    if (screenSize.height == 568.0f) {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f,568.0f)];
        [loadingView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setFrame:CGRectMake(140.0f,254.0f,40.0f,40.0f)];
    }
    else{
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f,480.0f)];
        [loadingView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f]];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator setFrame:CGRectMake(140.0f,210.0f,40.0f,40.0f)];
    }
    
    loadtimer = [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(load:) userInfo:nil repeats:YES];
    [loadtimer fire];
    timerFlag = 0;
    [[self view] addSubview:loadingView];
    
    [loadingView addSubview:indicator];
    [indicator startAnimating];
}

-(void)netAccessEnd{
    [indicator stopAnimating];
    [loadtimer invalidate];
    loadtimer = nil;
    [loadingView removeFromSuperview];
}
-(void)load:(NSTimer*)timer{
    timerFlag = timerFlag + 1;
    loadcheck = timerFlag % 2;
    NSLog(@"%d",timerFlag);
    if (loadcheck == 0) {
        [loadingImgView removeFromSuperview];
        NSString *load1_path = [[NSString alloc] init];
        load1_path = [[NSBundle mainBundle] pathForResource:@"loading1" ofType:@"png"];
        UIImage *loadImg = [[UIImage alloc] initWithContentsOfFile:load1_path];
        loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(60.0f, 140.0f, 200.0f, 200.0f)];
        loadingImgView.clipsToBounds = YES;
        loadingImgView.contentMode = UIViewContentModeScaleAspectFill;
        loadingImgView.image = loadImg;
        
        [loadingView addSubview:loadingImgView];
    }else{
        [loadingImgView removeFromSuperview];
        NSString *load2_path = [[NSString alloc] init];
        load2_path = [[NSBundle mainBundle] pathForResource:@"loading2" ofType:@"png"];
        UIImage *loadImg = [[UIImage alloc] initWithContentsOfFile:load2_path];
        loadingImgView = [[UIImageView alloc] initWithFrame:CGRectMake(60.0f, 140.0f, 200.0f, 200.0f)];
        loadingImgView.clipsToBounds = YES;
        loadingImgView.contentMode = UIViewContentModeScaleAspectFill;
        loadingImgView.image = loadImg;
        
        [loadingView addSubview:loadingImgView];
    }

}

#pragma mark データ受信時に１回だけ呼ばれる

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    mutabledata = [[NSMutableData alloc]init];
}

#pragma mark 何度でも

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [mutabledata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"ここまで来てるってよ");
    [self netAccessEnd];
    
    if(connection == loaddataConnection){
        
        //ユーザーネーム,ユーザーid,アップデートフラグ取得
        
        NSString *php = [[NSString alloc] initWithBytes:mutabledata.bytes
                                                 length:mutabledata.length encoding:NSUTF8StringEncoding];
        NSArray *phparray = [php componentsSeparatedByString:@"&"];
        
        NSLog(@"チェック%@",php);
        
        NSString *user_idStr = [[NSString alloc] init];
        user_idStr = [phparray objectAtIndex:0];
        NSArray *user_idArray = [user_idStr componentsSeparatedByString:@"="];
        NSString *user_idS = [user_idArray objectAtIndex:1];
        user_id = [user_idS intValue];
    }
    if (connection == shopsearchConnection) {
        NSString *php = [[NSString alloc] initWithBytes:mutabledata.bytes
                                                 length:mutabledata.length encoding:NSUTF8StringEncoding];
        NSArray *phparray = [php componentsSeparatedByString:@"count"];
        
        int checkcount = [phparray count];
        NSLog(@"チェック%d",checkcount);
        
        
        for (int i = 0; i<checkcount-1; i++) {
            shopSearchName[i] = [[NSString alloc] init];
            shopSearchId[i] = [[NSString alloc] init];
            
            NSString *phpcheck = [phparray objectAtIndex:i+1];
            NSArray *checkCountArray = [phpcheck componentsSeparatedByString:@"&"];
            
            NSString *cellCheckStr = [checkCountArray objectAtIndex:0];
            NSArray *cellCheckArray = [cellCheckStr componentsSeparatedByString:@"="];
            NSString *cellCheckSt = [cellCheckArray objectAtIndex:1];
            shopSearchCount = [cellCheckSt intValue];
            
            NSString *nameStr = [checkCountArray objectAtIndex:1];
            NSArray *nameArray = [nameStr componentsSeparatedByString:@"="];
            NSString *nameSt = [nameArray objectAtIndex:1];
            shopSearchName[i] = nameSt;
            
            NSString *idStr = [checkCountArray objectAtIndex:2];
            NSArray *idArray = [idStr componentsSeparatedByString:@"="];
            NSString *idSt = [idArray objectAtIndex:1];
            shopSearchId[i] = idSt;
            
            NSString *contractStr = [checkCountArray objectAtIndex:3];
            NSArray *contractArray = [contractStr componentsSeparatedByString:@"="];
            NSString *contractSt = [contractArray objectAtIndex:1];
            shopSearchContract[i] = contractSt;
            
            [self.shopSearchNameMutableArray addObject:nameSt];
            [self.shopSearchIdMutableArray addObject:idSt];
            [self.shopSearchContractMutableArray addObject:contractSt];
            
            NSLog(@"公式か？%d=%@",i,shopSearchContract[i]);
        }
        [self writeShopsearch];
    }
    else if(connection == kisyusearchConnection){
        NSString *php = [[NSString alloc] initWithBytes:mutabledata.bytes
                                                 length:mutabledata.length encoding:NSUTF8StringEncoding];
        NSArray *phparray = [php componentsSeparatedByString:@"count"];
        
        int checkcount = [phparray count];
        NSLog(@"チェック%d",checkcount);
        
        for (int i = 0; i<checkcount-1; i++) {
            kisyuSearchName[i] = [[NSString alloc] init];
            kisyuSearchId[i] = [[NSString alloc] init];
            
            NSString *phpcheck = [phparray objectAtIndex:i+1];
            NSArray *checkCountArray = [phpcheck componentsSeparatedByString:@"&"];
            
            NSString *cellCheckStr = [checkCountArray objectAtIndex:0];
            NSArray *cellCheckArray = [cellCheckStr componentsSeparatedByString:@"="];
            NSString *cellCheckSt = [cellCheckArray objectAtIndex:1];
            kisyuSearchCount = [cellCheckSt intValue];
            
            NSString *nameStr = [checkCountArray objectAtIndex:1];
            NSArray *nameArray = [nameStr componentsSeparatedByString:@"="];
            NSString *nameSt = [nameArray objectAtIndex:1];
            kisyuSearchName[i] = nameSt;
            //NSLog(@"機種名前ないよ%@",nameSt);
            
            NSString *idStr = [checkCountArray objectAtIndex:2];
            NSArray *idArray = [idStr componentsSeparatedByString:@"="];
            NSString *idSt = [idArray objectAtIndex:1];
            kisyuSearchId[i] = idSt;
            //NSLog(@"機種IDこれだよん→%@",idSt);
            
            NSString *contractStr = [checkCountArray objectAtIndex:3];
            NSArray *contractArray = [contractStr componentsSeparatedByString:@"="];
            NSString *contractSt = [contractArray objectAtIndex:1];
            kisyuSearchContract[i] = contractSt;
            
            [self.kisyuSearchNameMutableArray addObject:nameSt];
            [self.kisyuSearchIdMutableArray addObject:idSt];
            [self.kisyuSearchContractMutableArray addObject:contractSt];
             
            //NSLog(@"公式か？%d=%@",i,kisyuSearchContract[i]);
        }
        [self writeKisyusearch];
    }
    if (connection == postConnection) {
        NSString *php = [[NSString alloc] initWithBytes:mutabledata.bytes
                                                 length:mutabledata.length encoding:NSUTF8StringEncoding];
        NSLog(@"投稿IDは%@",php);
        toukouId = [php intValue];
        [self toukouImgUpdata];
        [self toukouImgThumbUpdata];
    }
}
#pragma mark - 位置情報関係
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //NSLog(@"位置変更 latitude=%f longitude=%f",[newLocation coodinate].latitude,[newLocation coodinate].longitude);
    _longitude = newLocation.coordinate.longitude;
    _latitude = newLocation.coordinate.latitude;
    
    NSLog(@"位置は longitude=%f latitude=%f",_longitude,_latitude);
    
}

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    screenSize = [[UIScreen mainScreen] bounds].size;
   // [[GAI sharedInstance].defaultTracker set:kGAIScreenName value:@"Toukou"];
    [[[GAI sharedInstance] defaultTracker] set:kGAIScreenName value:@"Toukou"];
    [[[GAI sharedInstance] defaultTracker] send:[[GAIDictionaryBuilder createAppView] build]];
    bigFlag = 0;
    thumbFlag = 0;
    
    self.shopSearchNameMutableArray = [NSMutableArray array];
    self.shopSearchIdMutableArray = [NSMutableArray array];
    self.shopSearchContractMutableArray = [NSMutableArray array];
    
    self.kisyuSearchNameMutableArray = [NSMutableArray array];
    self.kisyuSearchIdMutableArray = [NSMutableArray array];
    self.kisyuSearchContractMutableArray = [NSMutableArray array];
    
    NSArray *osarray = [[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."];
    osVerdion = [[osarray objectAtIndex:0] intValue];
    
    //[kisyusearchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    /*
    int testtest = [defaults integerForKey:@"user_id"];
    NSLog(@"ゆーざーあいでぃー→%d",testtest);
    */
     
    user_id = (int)[defaults integerForKey:@"user_id"];
    
    imageSize = (int)[defaults integerForKey:@"imagesize"];
    NSLog(@"イメージサイズは%d",imageSize);
    NSLog(@"ユーザーイDは？%d",user_id);
    locationmanager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager.delegate = self;
        [locationmanager startUpdatingLocation];
    }
    else{
        
    }
    
    [self setup];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
