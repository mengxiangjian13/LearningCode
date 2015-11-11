//
//  ViewController.m
//  CompactConstraintDemo
//
//  Created by mengxiangjian on 15/11/11.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "CompactConstraint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     本demo目的是利用第三方代码CompactConstraint简便实现autolayout。
     
     要实现的效果是：
     1. 有三个子view
     2. 上面并排两个view，下面一个view。
     3. 上两个view宽度相同，中间间距20.
     4. 下面view和上面两个view左右到父视图的间距相同。
     5. 三个view的高度相同。
     6. 其他细节具体run demo
     */
    
    UIView *view1 = [UIView new];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:view1];
    view1.backgroundColor = [UIColor redColor];
    UIView *view2 = [UIView new];
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    view2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view2];
    
    UIView *view3 = [UIView new];
    view3.translatesAutoresizingMaskIntoConstraints = NO;
    view3.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view3];
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(view1,view2,view3);
    
    [self.view addCompactConstraints:@[@"view1.left = super.left + 20",
                                       @"view1.top = super.top + 20",
                                       @"view1.width = view2.width",
                                       @"view2.left = view1.right + 20",
                                       @"view2.top = view1.top",
                                       @"view2.right = super.right - 20",
                                       @"view3.bottom = super.bottom - 20",
                                       @"view2.height = view1.height",
                                       @"view3.height = view2.height",
                                       @"view3.top = view1.bottom + 20",
                                       @"view3.left = view1.left",
                                       @"view3.right = view2.right"
                                       ]
                             metrics:nil
                               views:viewDict];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
