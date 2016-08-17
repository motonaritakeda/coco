//
//  PopinfoReceiver.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@class PopinfoReceiver;

@protocol PopinfoReceiverDelegate <NSObject>
@optional

// ユーザーID取得完了イベントを受け取るデリゲートメソッドです。
- (void)popinfoReceiverDidGetPopinfoId:(PopinfoReceiver *)popinfoReceiver uid:(NSString *)uid;

// プッシュ通知を受信したイベントを受け取るデリゲートメソッドです。
- (void)popinfoReceiver:(PopinfoReceiver *)popinfoReceiver didReceivePopinfoMessage:(NSInteger)messageId popup:(NSString *)popup;

// プッシュ通知を受信した際に、そのお知らせのカテゴリを受け取るデリゲートメソッドです。
- (void)popinfoReceiver:(PopinfoReceiver *)popinfoReceiver didReceivePopinfoMessage:(NSInteger)messageId category:(NSString *)category result:(BOOL)result;

- (void)popinfoReceiver:(PopinfoReceiver *)popinfoReceiver updateMessagesResult:(BOOL)result;

- (void)popinfoReceiver:(PopinfoReceiver *)popinfoReceiver didUpdateLocation:(CLLocation *)newLocation type:(NSString *)type;

@end

typedef void (^setSegmentsCompletionHandler)(BOOL isOk, NSString *errorCode);
typedef void (^getSegmentsCompletionHandler)(BOOL isOk, NSString *errorCode, NSArray *segmentArray);

@interface PopinfoReceiver : NSObject

@property (nonatomic, assign) id<PopinfoReceiverDelegate> delegate;
@property (nonatomic, readonly) NSString *uid;
@property (nonatomic, readonly) NSString *registerdAPNsToken;
@property (nonatomic, readonly) NSString *sdkVersion;

+ (PopinfoReceiver *)sharedReceiver; // インスタンスをシングルトンにしたい場合
- (void)loadSettings;
- (void)updateMessages;
- (void)registerToken:(NSData *)dataToken;
- (void)receiveNotification:(NSDictionary *)notification;
- (void)enterBackgroundFetch;
- (int)getUnreadMessagesCounts:(NSString *)category;
- (void)changeMessageToRead:(NSInteger)messageId;
- (void)setSegments:(NSArray *)values forKey:(NSString *)key completion:(setSegmentsCompletionHandler)handler;
- (void)getSegmentsWithCompletion:(getSegmentsCompletionHandler)handler;
- (void)getSegmentsAllWithCompletion:(getSegmentsCompletionHandler)handler;
- (BOOL)trackEvent:(NSString *)name;
- (BOOL)trackEvent:(NSString *)name value:(NSString *)value;
- (void)didFindBluetoothDevice:(NSString *)deviceId rssi:(NSNumber *)rssi;

@end
