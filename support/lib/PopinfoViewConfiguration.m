//
//  PopinfoViewConfiguration.m
//  PopinfoReceiver
//
//  Copyright (c) 2014年 株式会社アイリッジ. All rights reserved.
//

#import "PopinfoViewConfiguration.h"

// お知らせ一覧/お知らせ詳細 共通
BOOL const kIpadSplitViewUse = NO;
BOOL const kRotateUse = NO;
NSString *const kLocalizableStrings = @"Localizable";

// お知らせ一覧ビュー（PopinfoListViewController）
float const kListViewCellHeight = 65.0f;
float const kListViewTimeLabelHeight = 25.0f;
float const kListViewTimeLabelWidth = 67.0f;
float const kListViewHorizontalMargin = 5.0f;
float const kListViewHorizontalMarginBetweenTitleAndTime = 3.0f;
int const kListViewLabelTagForTime = 1001;
int const kListViewLabelTagForTitle = 1002;
BOOL const kListViewColorUseWhenRead = NO;

// お知らせ詳細ビュー（PopinfoDetailViewController）
float const kDetailViewVerticalUpperMargin = 10.0f;
float const kDetailViewHorizontalMargin = 10.0f;
float const kDetailViewIconWidth = 60.0f;
float const kDetailViewIconHeight = 60.0f;
float const kDetailViewMarginBetweenIconAndAppliName = 8.0f;
float const kDetailViewAppliNameHeight = 25.0f;
float const kDetailViewUnderLineHeight = 0.5f;
float const kDetailViewTitleHeight = 70.0f;

@implementation PopinfoViewConfiguration

@end
