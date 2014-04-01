//
//  ClientViewController.m
//  CocoaAsyncSocketTest
//
//  Created by Xiangjian Meng on 14-4-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ClientViewController.h"

@interface ClientViewController ()

@end

@implementation ClientViewController

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
    
    GCDAsyncSocket *sockt = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [sockt connectToHost:@"127.0.0.1" onPort:8080 withTimeout:-1 error:nil];
    [sockt readDataWithTimeout:-1 tag:1];
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == 1)
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"server say: %@",string);
        
        NSString *hello = @"hello,server!";
        
        [sock writeData:[hello dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:2];
    }
    else if (tag == 3)
    {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"server say: %@",string);
        
        NSString *bye = @"bye";
        
        [sock writeData:[bye dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:4];
    }
    
    
    
    
}
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    if (tag == 2)
    {
        [sock readDataWithTimeout:-1 tag:3];
    }
    else if (tag == 4)
    {
        [sock disconnect];
    }
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"client socket disconnect");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
