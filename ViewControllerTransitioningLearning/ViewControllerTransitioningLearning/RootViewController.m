//
//  RootViewController.m
//  ViewControllerTransitioningLearning
//
//  Created by Xiangjian Meng on 14-5-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationControllerDelegate.h"
#import "SecondViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

- (void)pan:(id)sender
{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        CGPoint touchPoint = [pan locationInView:self.view];
        if (touchPoint.x > CGRectGetMinX(self.view.bounds))
        {
            NavigationControllerDelegate *aDelegate = (NavigationControllerDelegate *)self.delegate;
            aDelegate.interactViewController = [[UIPercentDrivenInteractiveTransition alloc] init];
            SecondViewController *sVC = [SecondViewController new];
            [self pushViewController:sVC animated:YES];
        }
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint transition = [pan translationInView:self.view];
        CGFloat d = (transition.x / CGRectGetWidth(self.view.bounds)) * -1;
        
        NavigationControllerDelegate *aDelegate = (NavigationControllerDelegate *)self.delegate;
        [(UIPercentDrivenInteractiveTransition *)aDelegate.interactViewController updateInteractiveTransition:d];
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        NavigationControllerDelegate *aDelegate = (NavigationControllerDelegate *)self.delegate;
        if ([pan velocityInView:self.view].x > 0)
        {
            [(UIPercentDrivenInteractiveTransition *)aDelegate.interactViewController cancelInteractiveTransition];
        }
        else
        {
            [(UIPercentDrivenInteractiveTransition *)aDelegate.interactViewController finishInteractiveTransition];
        }
        aDelegate.interactViewController = nil;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
