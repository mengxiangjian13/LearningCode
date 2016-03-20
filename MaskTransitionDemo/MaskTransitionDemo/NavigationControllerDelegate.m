//
//  NavigationControllerDelegate.m
//  MaskTransitionDemo
//
//  Created by mengxiangjian on 16/3/20.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "AnimatedTransitioning.h"

@implementation NavigationControllerDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    return [AnimatedTransitioning new];
}

@end
