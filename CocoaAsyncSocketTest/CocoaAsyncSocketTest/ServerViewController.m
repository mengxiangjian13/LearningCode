//
//  ServerViewController.m
//  CocoaAsyncSocketTest
//
//  Created by Xiangjian Meng on 14-4-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ServerViewController.h"

@interface ServerViewController ()

@end

@implementation ServerViewController

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
    
    GCDAsyncSocket *socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    if ([socket acceptOnPort:8080 error:nil])
    {
        NSLog(@"accept success");
    }
    else
    {
        NSLog(@"accept failure");
    }
    
}

- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket
{
    NSLog(@"did accept new socket");
    
    NSString *hello = @"hello,client!";
    [newSocket writeData:[hello dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
    
    [newSocket readDataWithTimeout:-1 tag:2];
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"didConnectToHost:%@,port:%d",host,port);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == 2)
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"client say: %@",string);
        
        NSString *bye = @"bye";
        [sock writeData:[bye dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:3];
    }
    else if (tag == 4)
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"client say: %@",string);
        
        [sock disconnect];
    }
    
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag;
{
    if (tag == 3)
    {
        [sock readDataWithTimeout:-1 tag:4];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"server socket disconnect");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
