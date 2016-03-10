//
//  ViewController.m
//  ChainProgrammingDemo
//
//  Created by mengxiangjian on 16/3/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Caculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    float result = self.cManager.add(3).sub(2).multi(9).divide(3).result;
    NSLog(@"result is %f",result);
    
    
    result = [NSObject makeCaculator:^(CaculatorManager *manager) {
        manager.add(3).sub(2).multi(9).divide(3);
    }];
    NSLog(@"result is %f",result);
    
    result = [NSObject makeCaculator:^(CaculatorManager *manager) {
        manager.add(7).sub(4).multi(8).divide(2);
    }];
    NSLog(@"result is %f",result);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
