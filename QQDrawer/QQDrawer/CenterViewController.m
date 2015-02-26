//
//  CenterViewController.m
//  QQDrawer
//
//  Created by Xiangjian Meng on 15/2/26.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "CenterViewController.h"
#import "DrawerViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(toggle)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)toggle
{
    NSLog(@"toggle toggle");
    
    DrawerViewController *drawerVC = (DrawerViewController *)[[UIApplication sharedApplication] keyWindow].rootViewController;
    
    if (drawerVC)
    {
        [drawerVC toggleViewControllerWithComletionBlock:^(BOOL finish) {
            NSLog(@"toggle finished");
        }];
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
