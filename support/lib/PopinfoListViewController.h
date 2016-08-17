//
//  PopinfoListViewController.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopinfoListBaseViewController.h"
#import "tapArea.h"

@interface PopinfoListViewController : PopinfoListBaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    tapArea *openmenuButton_info;
    UIView *saftyView;
    CGSize screenSize;
}

@property (retain, nonatomic) IBOutlet UITableView *listTableView;

- (void)selectRowAtMessageId:(NSInteger)messageId;

@end
