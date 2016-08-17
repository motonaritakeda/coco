// Copyright (c) 2011 Takayuki Miwa
// Licensed under The MIT License http://www.opensource.org/licenses/mit-license.php

#import "NavigationSupportController.h"

@interface NavigationSupportController()
- (NavigationDirection)_checkDirectionOnDisappear;
@end

@implementation NavigationSupportController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NavigationDirection dir = NavigationNone;
    if (!_alreadyViewed) {
        dir = NavigationForward;
    } else if (_behindAnother) {
        dir = NavigationBack;
    }
    [self viewWillAppear:animated direction:dir];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NavigationDirection dir = NavigationNone;
    if (!_alreadyViewed) {
        dir = NavigationForward;
        _alreadyViewed = YES;
    } else if (_behindAnother) {
        dir = NavigationBack;
        _behindAnother = NO;
    }
    [self viewDidAppear:animated direction:dir];
}

- (NavigationDirection)_checkDirectionOnDisappear
{
    NavigationDirection dir = NavigationNone;
    NSArray *stack = self.navigationController.viewControllers;
    _behindAnother = [stack lastObject] != self;
    if (_behindAnother) {
        if ([stack count] >= 2 && [stack objectAtIndex:([stack count] - 2)] == self) {
            dir = NavigationForward;
        } else {
            dir = NavigationBack;
        }
    }
    return dir;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self viewWillDisappear:animated direction:[self _checkDirectionOnDisappear]];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self viewDidDisappear:animated direction:[self _checkDirectionOnDisappear]];
}

- (void)viewWillAppear:(BOOL)animated direction:(NavigationDirection)direction{}
- (void)viewDidAppear:(BOOL)animated direction:(NavigationDirection)direction{}
- (void)viewWillDisappear:(BOOL)animated direction:(NavigationDirection)direction{}
- (void)viewDidDisappear:(BOOL)animated direction:(NavigationDirection)direction{}

@end
