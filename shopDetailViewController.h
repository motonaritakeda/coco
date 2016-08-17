//
//  shopDetailViewController.h
//  coco
//
//  Created by yuki on 2013/04/02.
//  Copyright (c) 2013年 Yuki Moriya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"
#import "shopDetailViewController.h"
#import "toukouViewController.h"
#import "PopinfoReceiver.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"


@interface shopDetailViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate,UIWebViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,CLLocationManagerDelegate,NJKWebViewProgressDelegate>
{
    //店舗詳細
    UINavigationController *navigationController;
    NSURLConnection *shopDetailConnection;
    UILabel *shopnameLabel;
    UIButton *insertFavoriteShopButton;
    UIButton *deleteFavoriteShopButton;
    UIButton *pastPushOpenButton;
    UIButton *pastPostOpenButton;
    
    CGSize screenSize;
    UIView *detailView;
    UIButton *modoruButton;
    
    int osVerdion;
    
    NJKWebViewProgressView *progressView;
    NJKWebViewProgress *progressProxy;
}
@end
