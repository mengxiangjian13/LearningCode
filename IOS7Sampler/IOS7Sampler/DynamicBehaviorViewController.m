//
//  DynamicBehaviorViewController.m
//  IOS7Sampler
//
//  Created by Xiangjian Meng on 13-10-22.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "DynamicBehaviorViewController.h"

@interface DynamicBehaviorViewController ()
{
    UIDynamicItemBehavior *itemBehavior;
    UICollisionBehavior *collisionBehavior;
    UIGravityBehavior *gravityBehavior;
    UIDynamicAnimator *animator;
}

@end

@implementation DynamicBehaviorViewController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
    //animator 要搞成全局变量。如果局部的，animator不会被其他人retain
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    gravityBehavior = [[UIGravityBehavior alloc] initWithItems:nil];
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:nil];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:nil];
    
    [animator addBehavior:gravityBehavior];
    [animator addBehavior:collisionBehavior];
    [animator addBehavior:itemBehavior];
}

- (void)tap:(id)sender
{
    int random = arc4random() % 40 + 1;
    NSString *filename = [NSString stringWithFormat:@"m%d",random];
    UIImage *image = [UIImage imageNamed:filename];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    
    CGPoint point = [tap locationInView:self.view];
    imageView.center = point;
    
    [gravityBehavior addItem:imageView];
    [collisionBehavior addItem:imageView];
    [itemBehavior addItem:imageView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
