//
//  ViewController.m
//  VFLAutoLayout
//
//  Created by Xiangjian Meng on 14/12/9.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"black button" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blackColor];
    [self.view addSubview:button];
    button.translatesAutoresizingMaskIntoConstraints = NO;//这句必须有，不让autoresizing影响自动布局
    
    // 水平约束是左右距离父view20，
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:NSDictionaryOfVariableBindings(button)];
    // 垂直约束是上面距离父view20，高度是30。
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[button(==30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(button)];
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"red button" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    button1.translatesAutoresizingMaskIntoConstraints = NO;//这句必须有，不让autoresizing影响自动布局
    [self.view addSubview:button1];
    
    // 水平约束 同button
    NSArray *constraints3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button1]-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(button1)];
    // 垂直约束是上面距离button 8，自身高度30.
    NSArray *constraints4 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-[button1(==30)]"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:NSDictionaryOfVariableBindings(button,button1)];
    [self.view addConstraints:constraints3];
    [self.view addConstraints:constraints4];
    
    /*
     Visual format language
     
     水平方向  　　　　　　  H:
     
     垂直方向  　　　　　　  V:
     
     Views　　　　　　　　 [view]
     
     SuperView　　　　　　|
     
     关系　　　　　　　　　>=,==,<=
     
     空间,间隙　　　　　　　-
     
     优先级　　　　　　　　@value
     
     */
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
