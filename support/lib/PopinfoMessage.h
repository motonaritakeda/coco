//
//  Message.h
//  PopinfoReceiver
//
//  Copyright (c) 2012年 株式会社アイリッジ. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface PopinfoMessage : NSManagedObject {
@private
}

@property (nonatomic, retain) NSNumber *piId;
@property (nonatomic, retain) NSString *piType;
@property (nonatomic, retain) NSString *piTitle;
@property (nonatomic, retain) NSString *piContent;
@property (nonatomic, retain) NSString *piContentType;
@property (nonatomic, retain) NSString *piUrl;
@property (nonatomic, retain) NSString *piIconUrl;
@property (nonatomic, retain) NSString *piShop;
@property (nonatomic, retain) NSDate *piTime;
@property (nonatomic, retain) NSString *piCategory;
@property (nonatomic, retain) NSNumber *piUnread;
@property (nonatomic, retain) NSString *piAppendix;

@end
