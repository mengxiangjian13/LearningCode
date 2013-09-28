//
//  ViewController.m
//  DynamicsPlayground
//
//  Created by Xiangjian Meng on 13-9-26.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollisionBehaviorDelegate>
{
    UIDynamicAnimator* _animator;
    UIGravityBehavior* _gravity;
    UICollisionBehavior *_collision;
    BOOL _firstContact;
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
    
    UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];//reference view that the animator uses to define its coordinate system.
    _gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
//    _gravity.gravityDirection = CGVectorMake(1, 1);//equal to set angle
    [_gravity setAngle:M_PI_2 magnitude:1];//default angle is M_PI_2
    [_animator addBehavior:_gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    _collision.collisionDelegate = self;
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x +
                                    barrier.frame.size.width, barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin
                                  toPoint:rightEdge];
    _collision.translatesReferenceBoundsIntoBoundary = YES;
//    _collision.collisionMode = UICollisionBehaviorModeItems;
    [_animator addBehavior:_collision];
    
    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehaviour.elasticity = 0.6;
    [_animator addBehavior:itemBehaviour];
    
    //在dynamic动态期间，设置与dynamic冲突的 transform 都是会被重写的。
    
}


- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
    UIView* view = (UIView*)item;
    view.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.3 animations:^{
        view.backgroundColor = [UIColor grayColor];
    }];
    
    if (!_firstContact)
    {
        _firstContact = YES;
        
        UIView* square = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor];
        [self.view addSubview:square];
        
        [_collision addItem:square];
        [_gravity addItem:square];
        
        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:view
                                                                   attachedToItem:square];
        [_animator addBehavior:attach];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
