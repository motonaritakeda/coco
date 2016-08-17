//
//  PopinfoConfiguration.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <Foundation/Foundation.h>

// アプリケーションIDの指定
extern NSString *const applicationID;

// 位置情報を利用する場合
extern BOOL const locationUse;

// Wi-Fiを利用する場合
extern BOOL const wifiUse;

// iBeaconを利用する場合
extern BOOL const bluetoothIBeaconUse;

// BLU300（Bluetoothだが非iBeacon）を利用する場合
extern BOOL const bluetoothDeviceUse;
extern NSString *const bluetoothDeviceDecryptKey;

// 統計解析
extern BOOL const analyticsUse;
extern BOOL const eventTrackingUse;

// その他特殊
extern BOOL const backgroundTaskUse;
extern BOOL const notifCenterClearUse;
extern BOOL const testLogUse;

@interface PopinfoConfiguration : NSObject

// iBeaconを利用する場合
+ (NSArray *)iBeaconUUIDArray;

@end
