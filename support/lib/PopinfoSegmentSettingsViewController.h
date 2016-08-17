//
//  PopinfoSegmentSettingsViewController.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopinfoSegmentSettingsBaseViewController.h"

@class PopinfoSegmentSettingsViewController;

@protocol PopinfoSegmentSettingsViewControllerDelegate <NSObject>

- (void)popinfoSegmentSettingsViewControllerDidFinishSetting:(PopinfoSegmentSettingsViewController *)viewController;

@end

@interface PopinfoSegmentSettingsViewController : PopinfoSegmentSettingsBaseViewController

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, assign) id delegate;

@end
