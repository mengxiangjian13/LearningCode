//
//  ViewController.m
//  LyricsAnimation
//
//  Created by Xiangjian Meng on 14-10-9.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"

#define Lyrics @"再也没有纯白的灵魂"

@interface ViewController ()
{
    CALayer *mask;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*  做歌词的动画，基本思路就是:
        底下放一个白色的label，上面放一个有色的label，通过设置并移动有色label的maskLayer，
        来实现歌词动画。动画利用CoreAnimation。
     */
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    bottomLabel.center = CGPointMake(viewWidth / 2.0, 200);
    bottomLabel.textColor = [UIColor whiteColor];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    bottomLabel.text = Lyrics;
    [self.view addSubview:bottomLabel];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    topLabel.center = CGPointMake(viewWidth / 2.0, 200);
    topLabel.textColor = [UIColor redColor];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.text = Lyrics;
    [self.view addSubview:topLabel];
    
    mask = [CALayer layer];
    mask.anchorPoint = CGPointZero;
    mask.backgroundColor = [[UIColor whiteColor] CGColor]; // 必须指定一个非clearColor的颜色。任意颜色都可以，只要有alpha通道。
    mask.frame = CGRectOffset(topLabel.bounds, -200, 0);
    topLabel.layer.mask = mask;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:@"开始" forState:UIControlStateNormal];
    button.center = self.view.center;
    [button addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)startAnimation:(id)sender
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    // keyTimes 和 values 可以根据歌词的节奏而细化，在此只是示意。
    animation.duration = 2.0;
    animation.keyTimes = @[@0,@0.5,@1.0];
    animation.values = @[@-200,@(-0.7*200),@0];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [mask addAnimation:animation forKey:@"MaskAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
