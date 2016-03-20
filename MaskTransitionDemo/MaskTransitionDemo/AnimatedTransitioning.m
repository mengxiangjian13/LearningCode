//
//  AnimatedTransitioning.m
//  MaskTransitionDemo
//
//  Created by mengxiangjian on 16/3/20.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "AnimatedTransitioning.h"
#import "ViewController.h"

@interface AnimatedTransitioning ()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@end

@implementation AnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    
    UIView *containerView = [transitionContext containerView];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    // 添加子view
    [containerView addSubview:toVC.view];
    
    ViewController *_fromVC = (ViewController *)fromVC;
    UIButton *button = _fromVC.popButton;
    
    // 算出初始圆形path，再算出最后圆形的半径，再算出最后的圆形path。
    UIBezierPath *initPath = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGFloat width = button.center.x;
    CGFloat height = button.center.y - fromVC.view.frame.size.height;
    CGFloat radius = sqrt(height * height + width * width);
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, - radius, - radius)];
    
    // 赋值mask
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = finalPath.CGPath;
    toVC.view.layer.mask = layer;
    
    // path动画，赋值初始path，和最后的path。
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(initPath.CGPath);
    animation.toValue  = (__bridge id _Nullable)(finalPath.CGPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    [layer addAnimation:animation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
