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
    
    //baseAnimation 基本动画
    UIView *square = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 50, 50)];
    square.backgroundColor = [UIColor redColor];
    [self.view addSubview:square];
    
    CABasicAnimation *lineAnimation = [CABasicAnimation animation];
    lineAnimation.keyPath = @"position.x";
    lineAnimation.fromValue = @100;
    lineAnimation.toValue = @250;
    lineAnimation.duration = 1.0;
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
