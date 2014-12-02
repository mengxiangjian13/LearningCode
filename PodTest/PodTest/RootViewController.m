//
//  RootViewController.m
//  PodTest
//
//  Created by Xiangjian Meng on 14-7-7.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    UIView *circle;
}

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
    self.title = @"usage";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:@"animate!" forState:UIControlStateNormal];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100);
    [button addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    circle.alpha = 0.0;
    circle.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 100);
    circle.backgroundColor = [UIColor redColor];
    circle.layer.cornerRadius = 25;
    [self.view addSubview:circle];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [circle addGestureRecognizer:pan];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 100, 320, 50)];
    label.textColor = [UIColor blackColor];
    label.text = @"圆形可拖动，放手渐停";
    [self.view addSubview:label];
}

- (void)animate:(id)sender
{
    [circle.layer pop_removeAllAnimations];
    
    circle.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 100);
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    spring.springBounciness = 15;
    
    
    POPSpringAnimation *alpha = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alpha.fromValue = @0.3;
    alpha.toValue = @1.0;
    
    
    [circle.layer pop_addAnimation:spring forKey:@"scale"];
    [circle.layer pop_addAnimation:alpha forKey:@"alpha"];
}

- (void)pan:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan)
    {
        [circle.layer pop_removeAllAnimations];
    }
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        CGPoint transition = [pan translationInView:self.view];
        
        CGPoint center = circle.center;
        center.x += transition.x;
        center.y += transition.y;
        circle.center = center;
        
        [pan setTranslation:CGPointZero inView:circle];
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [pan velocityInView:self.view];
        [self addDecayAnimationWithVelocity:velocity];
    }
}

- (void)addDecayAnimationWithVelocity:(CGPoint)velocity
{
    POPDecayAnimation *decay = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPosition];
    decay.fromValue = [NSValue valueWithCGPoint:circle.center];
    decay.velocity = [NSValue valueWithCGPoint:velocity];
    [circle.layer pop_addAnimation:decay forKey:@"decay"];
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
