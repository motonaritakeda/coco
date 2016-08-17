//
//  PopinfoDetailViewController.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopinfoDetailBaseViewController.h"

@interface PopinfoDetailViewController : PopinfoDetailBaseViewController <UISplitViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *basicScrollView;
@property (nonatomic, retain) UIPopoverController *masterPopoverController;

- (void)reloadMyViews;

@end
