//
//  MMMAnimatedTransitioning.m
//  IOS7Sampler
//
//  Created by Xiangjian Meng on 13-10-28.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#define DefaultDuration 0.5

#import "MMMAnimatedTransitioning.h"

@implementation MMMAnimatedTransitioning


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return DefaultDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *incomeViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *outcomeViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *contentView = [transitionContext containerView];
    
    [contentView addSubview:incomeViewController.view];
    
    [contentView addSubview:outcomeViewController.view];
    
    outcomeViewController.view.alpha = 1.0;
    incomeViewController.view.alpha = 0.0;
    
    [UIView animateWithDuration:DefaultDuration
                     animations:^{
                         outcomeViewController.view.alpha = 0.0;
                         incomeViewController.view.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}

@end
