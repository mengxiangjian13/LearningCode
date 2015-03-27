//
//  OrdinaryViewController.m
//  MasonryDemo
//
//  Created by Xiangjian Meng on 15/3/27.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "OrdinaryViewController.h"
#import <Masonry/Masonry.h>

@interface OrdinaryViewController ()

@end

@implementation OrdinaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    
    // 在设置各种约束之前，必须将view添加到super view中。
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    UIView *lastView = view;
    for (int i = 0; i < 5; i ++)
    {
        UIView *view = [UIView new];
        NSInteger red = arc4random_uniform(255);
        NSInteger green = arc4random_uniform(255);
        NSInteger blue = arc4random_uniform(255);
        view.backgroundColor = [UIColor colorWithRed:(CGFloat)red/255
                                               green:(CGFloat)green/255
                                                blue:(CGFloat)blue/255
                                               alpha:1.0];
        
        [lastView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(lastView).with.insets(UIEdgeInsetsMake(10, 5, 15, 20));
        }];
        
        lastView = view;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
