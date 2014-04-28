//
//  RootViewController.m
//  QQSDKTest
//
//  Created by Xiangjian Meng on 14-4-28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <TencentSessionDelegate>
{
    TencentOAuth *oauth;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(0, 0, 100, 100);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    loginButton.center = self.view.center;
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    oauth = [[TencentOAuth alloc] initWithAppId:@"101074459"
                                    andDelegate:self];
}

- (void)login
{
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    [oauth authorize:permissions];
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    NSLog(@"登录成功");
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败 是否用户取消:%d",cancelled);
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork
{
    NSLog(@"网络有问题");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
