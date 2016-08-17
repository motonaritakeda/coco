//
//  PopinfoViewConfiguration.h
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import <Foundation/Foundation.h>

// お知らせ一覧/お知らせ詳細 共通
extern BOOL const kIpadSplitViewUse;
extern BOOL const kRotateUse;
extern NSString *const kLocalizableStrings;

// お知らせ一覧ビュー（PopinfoListViewController）
extern float const kListViewCellHeight;
extern float const kListViewTimeLabelHeight;
extern float const kListViewTimeLabelWidth;
extern float const kListViewHorizontalMargin;
extern float const kListViewHorizontalMarginBetweenTitleAndTime;
extern int const kListViewLabelTagForTime;
extern int const kListViewLabelTagForTitle;
extern BOOL const kListViewColorUseWhenRead;

// お知らせ詳細ビュー（PopinfoDetailViewController）
extern float const kDetailViewVerticalUpperMargin;
extern float const kDetailViewHorizontalMargin;
extern float const kDetailViewIconWidth;
extern float const kDetailViewIconHeight;
extern float const kDetailViewMarginBetweenIconAndAppliName;
extern float const kDetailViewAppliNameHeight;
extern float const kDetailViewUnderLineHeight;
extern float const kDetailViewTitleHeight;

@interface PopinfoViewConfiguration : NSObject

@end
