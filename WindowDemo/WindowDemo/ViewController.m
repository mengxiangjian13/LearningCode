//
//  ViewController.m
//  WindowDemo
//
//  Created by mengxiangjian on 16/1/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "WindowHelper.h"


@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showRedView:(id)sender {
    
    [[WindowHelper sharedHelper] showRed];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
