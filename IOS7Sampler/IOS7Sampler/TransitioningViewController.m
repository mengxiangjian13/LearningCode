//
//  TransitioningViewController.m
//  IOS7Sampler
//
//  Created by Xiangjian Meng on 13-10-28.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "TransitioningViewController.h"
#import "MMMAnimatedTransitioning.h"

@interface TransitioningViewController () <UINavigationControllerDelegate>

@end

@implementation TransitioningViewController
@synthesize style;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"plain" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = CGPointMake(160, 100);
    [button addTarget:self action:@selector(clickPlain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *fadeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [fadeButton setTitle:@"fade" forState:UIControlStateNormal];
    [fadeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    fadeButton.frame = CGRectMake(0, 0, 100, 100);
    fadeButton.center = CGPointMake(160, 200);
    [fadeButton addTarget:self action:@selector(clickFade) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fadeButton];
    
    
}

- (void)clickPlain
{
    self.style = TransitioningStylePlain;
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickFade
{
    self.style = TransitioningStyleFade;
    
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark -
#pragma mark UINavigationController
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    
    NSObject <UIViewControllerAnimatedTransitioning> *animator;
    
    switch (style) {
        case TransitioningStyleFade:
            animator = [[MMMAnimatedTransitioning alloc] init];
            break;
            
        default:
        animator = nil;
            break;
    }
    
    return animator;
}

- (void)dealloc
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
