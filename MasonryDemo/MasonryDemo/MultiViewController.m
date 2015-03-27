//
//  MultiViewController.m
//  MasonryDemo
//
//  Created by Xiangjian Meng on 15/3/27.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "MultiViewController.h"
#import <Masonry/Masonry.h>

@interface MultiViewController ()

@end

@implementation MultiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view1];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(view1.mas_left).with.offset(-20);
        make.width.equalTo(view1);
        make.height.mas_equalTo(150);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.right.equalTo(self.view).with.offset(-20);
        make.width.equalTo(view);
        make.height.equalTo(view);
    }];
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
