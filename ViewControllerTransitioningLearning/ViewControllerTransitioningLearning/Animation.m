//
//  Animation.m
//  ViewControllerTransitioningLearning
//
//  Created by Xiangjian Meng on 14-5-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "Animation.h"

@implementation Animation

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.alpha = 0.0;
    
    //duration 必须于上面的一致
    [UIView animateWithDuration:1.0
                     animations:^{
                         toVC.view.alpha = 1.0;
                         fromVC.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
                     }completion:^(BOOL finished) {
                         fromVC.view.transform = CGAffineTransformIdentity;
                         //必须调用completeTransition方法
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end
