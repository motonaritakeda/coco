//
//  PopinfoListViewBaseController.h
//  PopinfoReceiver
//
//  Copyright (c) 2012年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoMessageSuperViewController.h"

@interface PopinfoListBaseViewController : PopinfoMessageSuperViewController {
    NSArray *_messages;
    NSString *_category;
    int stateRead;
    int stateUnread;
}

@property (nonatomic, retain) NSString *category; // 現在表示したいカテゴリ

- (void)reloadMessagesWithCategory;
- (NSArray *)retrievePopinfoMessages:(NSString *)category;
- (NSInteger)maxMessageNumber;

@end
