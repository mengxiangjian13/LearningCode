//
//  ViewController.m
//  NavigationTransitionDemo
//
//  Created by Xiangjian Meng on 15/4/1.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "AnimatedTransition.h"

@interface ViewController () <UINavigationControllerDelegate>
{
    UIPercentDrivenInteractiveTransition *interactiveTransition;
    AnimatedTransition *animatedTransition;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    self.navigationController.delegate = weakSelf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}


- (void)pan:(UIPanGestureRecognizer *)pan
{
    CGFloat progress = [pan translationInView:self.view].x / self.view.bounds.size.width;
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [interactiveTransition updateInteractiveTransition:progress];
    }
    else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled)
    {
        if (progress >= 0.5)
        {
            [interactiveTransition finishInteractiveTransition];
        }
        else
        {
            [interactiveTransition cancelInteractiveTransition];
        }
        
        interactiveTransition = nil;
    }
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (!animatedTransition)
    {
        animatedTransition = [AnimatedTransition new];
    }
    
    return animatedTransition;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (!interactiveTransition)
    {
        interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    
    return interactiveTransition;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
