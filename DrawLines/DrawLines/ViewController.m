//
//  ViewController.m
//  DrawLines
//
//  Created by Xiangjian Meng on 14-9-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import "DrawLineView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    DrawLineView *drawLineView = [[DrawLineView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:drawLineView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
