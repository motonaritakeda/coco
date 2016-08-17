//
//  toukouViewController.h
//  coco
//
//  Created by yuki on 2013/04/02.
//  Copyright (c) 2013年 Yuki Moriya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "tapArea.h"
//#import <AFNetworking.h>

@interface toukouViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIWebViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate,UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    //投稿ページ
    int selecthole;
    int selectkisyu;
    int kensakunum;
    UIView *toukouView;
    UIImageView *toukouHeaderImgView;
    tapArea *backButton;
    tapArea *cameraButton;
    tapArea *checkinButton;
    tapArea *toukouButton;
    tapArea *kisyuButton;
    UIImagePickerController *ipc;
    UIImage *postimg;
    UIImage *postimg_thumb;
    CGImageRef imageRef;
    UITextView *toukouTextView;
    UIView *bannerView;
    UIView *bannerView2;
    UILabel *shopNameLabel;
    UILabel *kisyuNameLabel;
    UIImageView *cameraImgView;
    UIButton *coverButton;
    NSString *toukouTextStr;
    NSURLConnection *postConnection;
    NSURLConnection *postImgConnection;
    int toukouId;
    int bigFlag;
    int thumbFlag;
    int selectPhotoFlag;
    int selectHoleFlag;
    int selectKisyuFlag;
    //チュートリアル画像？
    UIWebView *bannerWebView1;
    //お店を探す
    UIView *shopView;
    UIImageView *shopHeaderImgView;
    UIImageView *kisyuHeaderImgview;
    NSURLConnection *shopsearchConnection;
    NSURLConnection *kisyusearchConnection;
    UITableView *shopsearchTableView;
    UITableView *kisyusearchTableView;
    NSString *shopSearchName[10000];
    NSString *shopSearchId[10000];
    NSString *shopSearchContract[10000];
    NSString *kisyuSearchName[10000];
    NSString *kisyuSearchId[10000];
    NSString *kisyuSearchContract[10000];
    NSString *defKisyu;
    int shopSearchCount;
    int shopSearchIdInt;
    int kisyuSearchIdInt;
    int kisyuSearchCount;
    UISearchBar *shopSearchBar;
    UISearchBar *kisyuSearchBar;
    tapArea *shopBackButton;
    CLLocationManager *locationmanager;
    CLLocationDegrees _longitude;
    CLLocationDegrees _latitude;
    NSString *shopName;
    NSString *kisyuName;
    //データ関係
    NSString *uuid;
    int user_id;
    int shop_id;
    NSURLConnection *loaddataConnection;
    CGSize screenSize;
    UIView *loadingView;
    UIImageView *loadingImgView;
    int timerFlag;
    NSTimer *loadtimer;
    int loadcheck;
    NSMutableData *mutabledata;
    int profimgFlag;
    NSString *profimgStr;
    UIActivityIndicatorView *indicator;
    
    int osVerdion;
    int imageSize;
    
    UIView *doneView;
    UIWebView *doneWebView;
    UIButton *doneCloseButton;
    
    int ipcFlag;
    int charCount;
    UILabel *charCountLabel;
    
    UIAlertView *twAlertView;
    int twFlag;
    
    UIAlertView *postCheckView;
    
    /*
    NSString *accessToken;
    NSString *accessTokenSecret;
    */
    
}

@property(retain,nonatomic)UIImage *postimg_thumb;
@property(retain,nonatomic)NSString *toukouTextStr;
@property(retain,nonatomic)NSMutableArray *shopSearchNameMutableArray;
@property(retain,nonatomic)NSMutableArray *shopSearchIdMutableArray;
@property(retain,nonatomic)NSMutableArray *shopSearchContractMutableArray;
@property(retain,nonatomic)NSMutableArray *kisyuSearchNameMutableArray;
@property(retain,nonatomic)NSMutableArray *kisyuSearchIdMutableArray;
@property(retain,nonatomic)NSMutableArray *kisyuSearchContractMutableArray;

@end
