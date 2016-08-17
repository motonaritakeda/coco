//
//  PopinfoPadViewController.h
//  PopinfoReceiver
//
//  Copyright (c) 2012年 株式会社アイリッジ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopinfoListViewController, PopinfoDetailViewController;

@interface PopinfoPadViewController : UISplitViewController

@property (nonatomic, assign) NSInteger messageId;
@property (nonatomic, retain) PopinfoDetailViewController *detailVC;
@property (nonatomic, retain) PopinfoListViewController *listVC;

@end
