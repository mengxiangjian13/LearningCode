//
//  ViewController.m
//  DynamicsPlayground
//
//  Created by Xiangjian Meng on 13-9-26.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIView* square = [[UIView alloc] initWithFrame:
                      CGRectMake(100, 100, 100, 100)];
    square.backgroundColor = [UIColor grayColor];
    [self.view addSubview:square];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];//reference view that the animator uses to define its coordinate system.
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
//    [_gravity setAngle:M_PI_2 magnitude:1];//default angle is M_PI_2
    [_animator addBehavior:_gravity];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
