//
//  ViewController.m
//  MySwitch
//
//  Created by Xiangjian Meng on 15/3/12.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "MySwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    MySwitch *mySwitch = [[MySwitch alloc] initWithDrawingPoint:CGPointMake(100, 100)];
    mySwitch.onTitle = @"建议";
    mySwitch.offTitle = @"问题";
    mySwitch.offTitleColor = [UIColor colorWithRed:0.706f green:0.000f blue:0.000f alpha:1.00f];
    mySwitch.onTitleColor = [UIColor whiteColor];
    [self.view addSubview:mySwitch];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
