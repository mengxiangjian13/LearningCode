//
//  AnimatedTransition.m
//  NavigationTransitionDemo
//
//  Created by Xiangjian Meng on 15/4/1.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "AnimatedTransition.h"

@implementation AnimatedTransition

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    [[transitionContext containerView] insertSubview:toVC.view belowSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         NSLog(@"fff");
                         fromVC.view.transform = CGAffineTransformMakeTranslation(375, 0);
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
