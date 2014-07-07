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
    
    circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    circle.alpha = 0.0;
    circle.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) - 100);
    circle.backgroundColor = [UIColor redColor];
    circle.layer.cornerRadius = 50;
    [self.view addSubview:circle];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:@"animate!" forState:UIControlStateNormal];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100);
    [button addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)animate:(id)sender
{
    [circle.layer pop_removeAllAnimations];
    
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    spring.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    spring.toValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];
    [circle.layer pop_addAnimation:spring forKey:@"scale"];
    
    
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
