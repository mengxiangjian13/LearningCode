//
//  ViewController.m
//  MultipeerDemo
//
//  Created by Xiangjian Meng on 15/1/28.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

// 创建一个服务标识
static NSString * const ServiceType = @"service";

@interface ViewController () <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate>
{
    MCPeerID *peerId;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = self.view.center;
    [button addTarget:self action:@selector(advertise) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"广播" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *browser = [UIButton buttonWithType:UIButtonTypeSystem];
    browser.frame = CGRectMake(0, 0, 100, 50);
    browser.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100);
    [browser addTarget:self action:@selector(browser) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"浏览" forState:UIControlStateNormal];
    [self.view addSubview:browser];
}

- (void)advertise
{
    NSLog(@"开始广播");
    
    // peerID 可以设置昵称，或者干脆就使用设备号。
    peerId = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
    
    // 广播. serviceType不能超过15个字符
    MCNearbyServiceAdvertiser *advertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:peerId
                                                                              discoveryInfo:nil
                                                                                serviceType:ServiceType];
    advertiser.delegate = self;
    [advertiser startAdvertisingPeer];
}

- (void)browser
{
    NSLog(@"开始浏览");
    MCPeerID *bPeer = [[MCPeerID alloc] initWithDisplayName:@"client"];
    MCNearbyServiceBrowser *browser = [[MCNearbyServiceBrowser alloc] initWithPeer:bPeer
                                                                       serviceType:ServiceType];
    
    MCSession *session = [[MCSession alloc] initWithPeer:bPeer
                                        securityIdentity:nil
                                    encryptionPreference:MCEncryptionNone];
    session.delegate = self;
    
    MCBrowserViewController *browserVC = [[MCBrowserViewController alloc] initWithBrowser:browser session:session];
    browserVC.delegate = self;
    
    [self presentViewController:browserVC
                       animated:YES
                     completion:^{
                         [browser startBrowsingForPeers];
                     }];
}

#pragma mark -
#pragma mark MCBrowserViewControllerDelegate
// Notifies the delegate, when the user taps the done button
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    
}

// Notifies delegate that the user taps the cancel button.
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    
}

#pragma mark -
#pragma mark MCNearbyServiceAdvertiserDelegate

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    /*
     得到其他人的邀请。可以被调用多次。
     附加了邀请人的peer信息，可以拒绝邀请或者接受邀请。
     如果接受邀请，就需要创建MCSession。通过invitationHandler返回。
     */
    
    //创建session，可以设置安全策略。加密会降低传输速率。
    MCSession *session = [[MCSession alloc] initWithPeer:peerId
                                        securityIdentity:nil
                                    encryptionPreference:MCEncryptionNone];
    session.delegate = self;
    
    invitationHandler(YES,session);
    
}

#pragma mark -
#pragma mark MCSessionDelegate
// Remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    
}

// Received data from remote peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    
}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    
}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    
}

// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
