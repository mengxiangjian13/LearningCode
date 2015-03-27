//
//  CardViewController.m
//  MasonryDemo
//
//  Created by Xiangjian Meng on 15/3/27.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "CardViewController.h"
#import <Masonry/Masonry.h>

@interface CardViewController ()

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *avartaView = [UIImageView new];
    avartaView.backgroundColor = [UIColor redColor];
    [self.view addSubview:avartaView];
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor yellowColor];
    label.text = @"姓名";
    [self.view addSubview:label];
    
    UILabel *descLabel = [UILabel new];
    descLabel.textColor = [UIColor blackColor];
    descLabel.backgroundColor = [UIColor orangeColor];
    descLabel.numberOfLines = 0;
    descLabel.text = @"地址:xxxx\n电话:xxxxx";
    [self.view addSubview:descLabel];
    
    [avartaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(self.view).with.offset(80);
        make.left.equalTo(self.view).with.offset(20);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avartaView.mas_right).with.offset(20);
        make.top.equalTo(self.view).with.offset(80);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(20);
    }];
    
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(20);
        make.top.equalTo(avartaView.mas_bottom).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_equalTo(100);
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
