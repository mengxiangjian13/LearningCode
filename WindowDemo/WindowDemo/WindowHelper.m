//
//  WindowHelper.m
//  WindowDemo
//
//  Created by mengxiangjian on 16/1/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "WindowHelper.h"
#import "RedViewController.h"

@interface WindowHelper () {
    UIWindow *keyWindow;
    UIWindow *redWindow;
}

@end

@implementation WindowHelper

+ (instancetype)sharedHelper {
    static WindowHelper *sharedHelper = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedHelper = [WindowHelper new];
    });
    return sharedHelper;
}

- (void)startWithKeyWindow:(UIWindow *)window {
    keyWindow = window;
}

- (void)showRed {
    [keyWindow resignKeyWindow];
    UIWindow *window = [[UIWindow alloc] initWithFrame:keyWindow.bounds];
    RedViewController *vc = [RedViewController new];
    window.rootViewController = vc;
    [window makeKeyAndVisible];
    redWindow = window;
}

- (void)quitRed {
    [redWindow resignKeyWindow];
    [keyWindow makeKeyAndVisible];
}

@end
