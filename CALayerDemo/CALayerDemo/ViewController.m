//
//  ViewController.m
//  CALayerDemo
//
//  Created by Xiangjian Meng on 15/1/6.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"splash4.jpg"];
    
    self.view.layer.contents = (__bridge id)(image.CGImage);
    self.view.layer.contentsGravity = kCAGravityResizeAspect;
    // 切割
    self.view.layer.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
