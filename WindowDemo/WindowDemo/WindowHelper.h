//
//  WindowHelper.h
//  WindowDemo
//
//  Created by mengxiangjian on 16/1/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WindowHelper : NSObject

+ (instancetype)sharedHelper;

- (void)startWithKeyWindow:(UIWindow *)window;

- (void)showRed;

- (void)quitRed;

@end
