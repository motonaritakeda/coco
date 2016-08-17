//
//  PopinfoPadViewController.m
//  PopinfoReceiver
//
//  Copyright (c) 2012年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoPadViewController.h"
#import "PopinfoDetailViewController.h"
#import "PopinfoListViewController.h"
#import "PopinfoViewConfiguration.h"

@implementation PopinfoPadViewController

@synthesize detailVC;
@synthesize listVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.listVC = [[PopinfoListViewController alloc] initWithNibName:@"PopinfoListViewController" bundle:[NSBundle mainBundle]];
        self.listVC.title = [[NSBundle mainBundle] localizedStringForKey:@"popinfoTitle1" value:@"お知らせ一覧" table:kLocalizableStrings];
        self.detailVC = [[PopinfoDetailViewController alloc] initWithNibName:@"PopinfoDetailViewController" bundle:[NSBundle mainBundle]];
        UINavigationController *masterNavigationController = [[[UINavigationController alloc] initWithRootViewController:self.listVC] autorelease];
        UINavigationController *detailNavigationController = [[[UINavigationController alloc] initWithRootViewController:self.detailVC] autorelease];
        self.delegate = self.detailVC;
        self.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
    }
    
    return self;
}

- (void)dealloc
{
    self.detailVC = nil;
    self.listVC = nil;
    
    [super dealloc];
}

#pragma mark - Rotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Property

- (NSInteger)messageId
{
    return self.detailVC.messageId;
}

- (void)setMessageId:(NSInteger)messageId
{
    [self.listVC selectRowAtMessageId:messageId];
    self.detailVC.messageId = messageId;
}

@end
