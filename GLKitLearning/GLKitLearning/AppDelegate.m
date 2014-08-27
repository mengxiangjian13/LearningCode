//
//  AppDelegate.m
//  GLKitLearning
//
//  Created by Xiangjian Meng on 14-8-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "AppDelegate.h"
#import <GLKit/GLKit.h>
#import <QuartzCore/QuartzCore.h>
#import "RootViewController.h"

@interface AppDelegate () <GLKViewDelegate,GLKViewControllerDelegate>
{
    CGFloat curRed;
    BOOL isIncreasing;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    isIncreasing = YES;
    curRed = 0.0;
    
    
    // 以下注释掉的代码打开同样好使
    
//    // 生成OpenGL上下文，用于绘画
//    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
//    
//    // 创建GLKView
//    GLKView *view = [[GLKView alloc] initWithFrame:[[UIScreen mainScreen]bounds]
//                                           context:context];
//    view.delegate = self;
//    [self.window addSubview:view];
//    
//    GLKViewController *viewController = [[GLKViewController alloc] init];
//    viewController.view = view;
//    viewController.delegate = self;
//    // 规定每秒的变动帧数，即GLKViewController调用代理方法的一秒次数。
//    viewController.preferredFramesPerSecond = 60;
//    self.window.rootViewController = viewController;
    
    
    RootViewController *rootVC = [[RootViewController alloc] init];
    self.window.rootViewController = rootVC;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

// GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // 将GLKView清理成红色
    glClearColor(curRed, 0.0, 0.0, 1.0);
    // 真正的清理方法，清理颜色缓冲区
    glClear(GL_COLOR_BUFFER_BIT);
}

// GLKViewControllerDelegate
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    if (isIncreasing)
    {
        curRed += 1.0 * controller.timeSinceLastUpdate;
        if (curRed >= 1)
        {
            isIncreasing = NO;
        }
    }
    else
    {
        curRed -= 1.0 * controller.timeSinceLastUpdate;
        if (curRed <= 0)
        {
            isIncreasing = YES;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
