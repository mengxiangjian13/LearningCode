//
//  ViewController.m
//  AskAndAnswer
//
//  Created by Xiangjian Meng on 15/2/3.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "JVFloatingDrawerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(openLeft) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"left" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)openLeft
{
    UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (rootVC && [rootVC isKindOfClass:[JVFloatingDrawerViewController class]])
    {
        JVFloatingDrawerViewController *vc = (JVFloatingDrawerViewController *)rootVC;
        [vc toggleDrawerWithSide:JVFloatingDrawerSideLeft
                        animated:YES
                      completion:^(BOOL finished) {
                          ;
                      }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
