// Copyright (c) 2011 Takayuki Miwa
// Licensed under The MIT License http://www.opensource.org/licenses/mit-license.php

#import <UIKit/UIKit.h>

typedef enum { NavigationBack, NavigationForward, NavigationNone } NavigationDirection;

@interface NavigationSupportController : UIViewController
{
    BOOL _behindAnother;
    BOOL _alreadyViewed;
}

- (void)viewWillAppear:(BOOL)animated direction:(NavigationDirection)direction;
- (void)viewDidAppear:(BOOL)animated direction:(NavigationDirection)direction;
- (void)viewWillDisappear:(BOOL)animated direction:(NavigationDirection)direction;
- (void)viewDidDisappear:(BOOL)animated direction:(NavigationDirection)direction;

@end