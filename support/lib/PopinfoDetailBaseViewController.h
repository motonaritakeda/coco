//
//  PopinfoDetailBaseViewController.h
//  PopinfoReceiver
//
//  Copyright (c) 2012年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoMessageSuperViewController.h"

@class PopinfoMessage;

@interface PopinfoDetailBaseViewController : PopinfoMessageSuperViewController {
    PopinfoMessage *_message;
    NSInteger _messageId;
    NSURLConnection *_connForURL;
}

@property NSInteger messageId;
@property BOOL fromDidSelectRow;

- (void)didSelectOpenUrl;
- (void)openUrl:(NSURL *)url;

@end
