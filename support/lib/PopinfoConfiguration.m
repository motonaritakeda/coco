//
//  PopinfoConfiguration.m
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoConfiguration.h"

//【必須】

// アプリケーションIDの指定
NSString *const applicationID = @"wzwaoXiAXpzMmqsVuNFARt6iUkyfykmv"; // 指定すべきアプリケーションID文字列は、popinfo配信管理画面からご確認ください。

//【以下 任意】

// 位置情報を利用する場合
BOOL const locationUse = YES; // セルベースのみを利用する場合もGPSを利用する場合もYESにする必要があります。

// Wi-Fiを利用する場合
BOOL const wifiUse = NO; // YESにする場合はlocationUseもYESにする必要があります。

// iBeaconを利用する場合
BOOL const bluetoothIBeaconUse = NO; // YESにする場合はlocationUseもYESにする必要があります。

// BLU300（Bluetoothだが非iBeacon）を利用する場合
BOOL const bluetoothDeviceUse = NO; // YESにする場合はlocationUseもYESにする必要があります。
NSString *const bluetoothDeviceDecryptKey = @""; // BLU300の復号キー文字列を指定してください。

// 統計解析（通常はこの値を変更しません）
BOOL const analyticsUse = YES; // 位置情報の統計的な分析機能
BOOL const eventTrackingUse = YES; // ユーザーの動作に関する統計的な分析機能

// その他特殊（通常はこの値を変更しません）
BOOL const backgroundTaskUse = YES;
BOOL const notifCenterClearUse = YES;

// デバッグ
BOOL const testLogUse = NO; // popinfoSDK内の主な動作をコンソールに表示させます。Apple審査に出す場合は必ずNOにしてください。

@implementation PopinfoConfiguration

// iBeaconを利用する場合
+ (NSArray *)iBeaconUUIDArray
{
    // ビーコンのUUID文字列を指定してください。
    // UUID文字列がNSArray内の一要素になります。複数のUUID文字列をNSArray内に入れることができます。
    return [NSArray arrayWithObjects:@"", nil];
}

@end
