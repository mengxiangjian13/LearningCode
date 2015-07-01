//
//  ViewController.m
//  MusicPlayer
//
//  Created by Xiangjian Meng on 15/7/1.
//  Copyright (c) 2015年 Boya. All rights reserved.
//

#import "ViewController.h"
#import "MyMusicPlayer.h"

@interface ViewController ()
{
    MyMusicPlayer *player;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MusicModel *music1 = [MusicModel new];
    music1.name = @"匆匆那年";
    music1.singer = @"王菲";
    music1.url = @"http://yinyueshiting.baidu.com/data2/music/240885332/124380645248400128.mp3?xcode=e55d21cc8ac811298c3c42cb27c397d9";
    
    MusicModel *music2 = [MusicModel new];
    music2.name = @"喜欢你";
    music2.singer = @"邓紫棋";
    music2.url = @"http://yinyueshiting.baidu.com/data2/music/239130183/12267411954000128.mp3?xcode=61143e7bc0ccb0c443e6e1d8249fc792";
    
    player = [[MyMusicPlayer alloc] initWithMusics:@[music1,music2]];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    [player clear];
    [super viewWillDisappear:animated];
}

- (IBAction)play:(id)sender
{
    [player play];
}

- (IBAction)previous:(id)sender
{
    [player previous];
}

- (IBAction)next:(id)sender
{
    [player next];
}

- (IBAction)pause:(id)sender
{
    [player pause];
}

- (IBAction)stop:(id)sender
{
    [player clear];
}

- (void) remoteControlReceivedWithEvent: (UIEvent *) receivedEvent
{
    [player remoteControlReceivedWithEvent:receivedEvent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
