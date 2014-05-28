//
//  NavigationControllerDelegate.m
//  ViewControllerTransitioningLearning
//
//  Created by Xiangjian Meng on 14-5-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "Animation.h"

@implementation NavigationControllerDelegate
@synthesize interactViewController;

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return interactViewController;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        return [Animation new];
    }
    
    return nil;
}



@end
