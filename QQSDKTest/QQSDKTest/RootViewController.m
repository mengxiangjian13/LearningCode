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
    UIButton *loginButton;
    UIButton *infoButton;
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
    
    loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    loginButton.frame = CGRectMake(0, 150, 100, 100);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    infoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    infoButton.frame = CGRectMake(0, 350, 100, 100);
    [infoButton setTitle:@"个人信息" forState:UIControlStateNormal];
    infoButton.center = self.view.center;
    infoButton.enabled = NO;
    [infoButton addTarget:self action:@selector(info) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
    
    oauth = [[TencentOAuth alloc] initWithAppId:@"101074459"
                                    andDelegate:self];
    
//    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:@"QQOauthData"];
//    if (dict)
//    {
//        oauth.accessToken = [dict objectForKey:@"AccessToken"];
//        oauth.expirationDate = [dict objectForKey:@"ExpirationDate"];
//        oauth.openId = [dict objectForKey:@"OpenId"];
//    }
    
    BOOL isLogin = [oauth isSessionValid];
    
    if (isLogin)
    {
        NSLog(@"登录了");
        [loginButton setTitle:@"已登录" forState:UIControlStateNormal];
        loginButton.enabled = NO;
        infoButton.enabled = YES;
    }
    else
    {
        NSLog(@"没有登录");
    }
        
}

- (void)login
{
    NSArray *permissions = [NSArray arrayWithObjects:@"all", nil];
    [oauth authorize:permissions];
}

- (void)info
{
    [oauth getUserInfo];
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin
{
    NSLog(@"登录成功");
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
//    if (oauth.accessToken)
//    {
//        [dict setObject:oauth.accessToken forKey:@"AccessToken"];
//    }
//    if (oauth.expirationDate)
//    {
//        [dict setObject:oauth.expirationDate forKey:@"ExpirationDate"];
//    }
//    if (oauth.openId)
//    {
//        [dict setObject:oauth.openId forKey:@"OpenId"];
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"QQOauthData"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    loginButton.enabled = NO;
    infoButton.enabled = YES;
    
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

- (void)getUserInfoResponse:(APIResponse*) response
{
    
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
