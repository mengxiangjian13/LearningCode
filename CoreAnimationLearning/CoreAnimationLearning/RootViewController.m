//
//  RootViewController.m
//  CoreAnimationLearning
//
//  Created by Xiangjian Meng on 14-6-25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = self.view.center;
    [button setTitle:@"走你！" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //baseAnimation 基本动画
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 50, 50)];
    square.backgroundColor = [UIColor redColor];
    [self.view addSubview:square];
    
    CABasicAnimation *lineAnimation = [CABasicAnimation animation];
    lineAnimation.keyPath = @"position.x";
    lineAnimation.fromValue = @0;
    lineAnimation.toValue = @250;
    lineAnimation.duration = 1.0;
    lineAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];//timing function
    [square.layer addAnimation:lineAnimation forKey:@"line"];
    
    //停留在最后的状态
    square.layer.position = CGPointMake(250, 55);
    
    // KeyFrameAnimation 关键帧动画
    UIView *form = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    form.backgroundColor = [UIColor greenColor];
    [self.view addSubview:form];
    
    CAKeyframeAnimation *shake = [CAKeyframeAnimation animation];
    shake.keyPath = @"position.x";
    shake.values = @[ @0, @10, @-10, @10, @0 ];
    shake.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    shake.duration = 0.4;
    
    //相对value
    shake.additive = YES;
    
    [form.layer addAnimation:shake forKey:@"shake"];
    
    UIView *satellite = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 20, 20)];
    satellite.backgroundColor = [UIColor blueColor];
    [self.view addSubview:satellite];
    
    CAKeyframeAnimation *circle = [CAKeyframeAnimation animation];
    circle.keyPath = @"position";
    circle.path = CFAutorelease(CGPathCreateWithEllipseInRect(CGRectMake(0, 0, 100, 100), NULL));
    circle.duration = 4.0;
    circle.repeatCount = HUGE_VALF;
    circle.additive = YES;
    circle.calculationMode = kCAAnimationPaced;//设置了paced就忽略了keytimes
    circle.rotationMode = kCAAnimationRotateAuto;
    
    [satellite.layer addAnimation:circle forKey:@"circle"];
    
    
    
    // animation group
    UIView *rect = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 50, 50)];
    rect.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rect];
    
    CABasicAnimation *run = [CABasicAnimation animation];
    run.keyPath = @"position.x";
    run.fromValue = @25;
    run.toValue = @295;
    run.duration = 4.0;
    
    CAKeyframeAnimation *rotate = [CAKeyframeAnimation animation];
    rotate.keyPath = @"transform.rotation.z";
    rotate.duration = 4.0;
    rotate.values = @[@0,@M_PI,@(2 *M_PI)];
    rotate.keyTimes = @[@0,@0.5,@1.0];
    rotate.additive = YES;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = 4.0;
    group.beginTime = 0.0;
    group.animations = @[run,rotate];
    
    [rect.layer addAnimation:group forKey:@"zouni"];
    
    rect.layer.position = CGPointMake(295, 530);
}

- (void)nextView:(id)sender
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
