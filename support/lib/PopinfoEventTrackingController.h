//
//  PopinfoEventTrackingController.h
//  PopinfoReceiver
//

@interface PopinfoEventTrackingController : NSObject

+ (PopinfoEventTrackingController *)sharedEventTrackingController;

- (BOOL)trackEvent:(NSString *)name value:(NSString *)value;
- (BOOL)trackEventOfActive;
- (BOOL)trackEventOfBackground;
- (BOOL)trackEventOfTerminate;
- (BOOL)trackEventOfPushWithMid:(NSNumber *)mid;
- (BOOL)trackEventOfNewInstall;
- (BOOL)trackEventOfUpdateAppliVersion;
- (BOOL)trackEventOfUpdateSdkVersion;
- (BOOL)trackEventOfUpdateOsVersion;
- (BOOL)trackEventOfUpdateDeviceModel;
- (BOOL)trackEventOfUpdateCarrierName;
- (BOOL)trackEventOfListViewAppear;
- (BOOL)trackEventOfListViewDisappear;
- (BOOL)trackEventOfDetailViewAppearWithMid:(NSInteger)mid;
- (BOOL)trackEventOfDetailViewDisappearWithMid:(NSInteger)mid;
- (BOOL)trackEventOfOpenUrl:(NSString *)urlStr mid:(NSInteger)mid;
- (BOOL)trackEventOfLinkUrl:(NSString *)urlStr mid:(NSInteger)mid;
- (BOOL)trackEventOfUpdateUserStatus:(NSString *)value;
- (BOOL)trackEventOfWifiIn:(NSString *)value;
- (BOOL)trackEventOfWifiOut:(NSString *)value;
- (BOOL)trackEventOfBluetoothIn:(NSString *)value;
- (BOOL)trackEventOfBluetoothOut:(NSString *)value;
- (BOOL)trackEventOfDelete:(int)deleteNum;
- (void)sendEventTracking;
- (void)sendEventTrackingImmediately;

@end
