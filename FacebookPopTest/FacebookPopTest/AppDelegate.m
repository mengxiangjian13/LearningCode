//
//  AppDelegate.m
//  FacebookPopTest
//
//  Created by Xiangjian Meng on 14-4-29.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    view.backgroundColor = [UIColor blueColor];
    view.layer.cornerRadius = 50;
    [self.window addSubview:view];
    
    [self performSelector:@selector(customPropertySpringAnimationWithView:) withObject:view afterDelay:1.0];
    
    [self performSelector:@selector(springViewWithView:) withObject:view afterDelay:3.0];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)springViewWithView:(UIView *)view
{
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
//    animation.velocity = @20.0;
    //springBounciness 调整弹性 值域[0,20]，值越大弹性越好
    animation.springBounciness = 18;
    //springSpeed 调整速度 值域[0,20]，值越大速度越快
    animation.springSpeed = 18;
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 300, 300)];
    [view.layer pop_addAnimation:animation forKey:@"size"];
}

- (void)customPropertySpringAnimationWithView:(UIView *)view
{
    //自定义模拟了一个position在Y轴上的动画
    POPMutableAnimatableProperty *prop = [POPMutableAnimatableProperty propertyWithName:@"custom.origin.y" initializer:^(POPMutableAnimatableProperty *_prop) {
        _prop.readBlock = ^(id obj, CGFloat values[]){
            values[0] = view.center.y;
        };
        
        _prop.writeBlock = ^(id obj, const CGFloat values[]){
            CGPoint point = CGPointMake(view.center.x, values[0]);
            view.center = point;
        };
    }];
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.property = prop;
    //    animation.velocity = @20.0;
    //springBounciness 调整弹性 值域[0,20]，值越大弹性越好
    animation.springBounciness = 18;
    //springSpeed 调整速度 值域[0,20]，值越大速度越快
    animation.springSpeed = 18;
    animation.toValue = @400;
    [view.layer pop_addAnimation:animation forKey:@"originY"];
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
