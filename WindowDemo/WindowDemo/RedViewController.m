//
//  RedViewController.m
//  WindowDemo
//
//  Created by mengxiangjian on 16/1/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "RedViewController.h"
#import "WindowHelper.h"

@interface RedViewController ()

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *shadow = [[UIView alloc] initWithFrame:self.view.bounds];
    shadow.backgroundColor = [UIColor colorWithWhite:0
                                               alpha:.5];
    [self.view addSubview:shadow];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    label.center = self.view.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.text = @"快来抢红包";
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = CGPointMake(150, 250);
    [button setTitle:@"退出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    [button addTarget:self
               action:@selector(quit)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)quit {
    [[WindowHelper sharedHelper] quitRed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    // 仅支持竖屏
    return UIInterfaceOrientationMaskPortrait;
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
