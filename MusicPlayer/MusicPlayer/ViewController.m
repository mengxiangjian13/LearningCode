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
    
    MusicModel *music = [MusicModel new];
    music.name = @"铃声";
    music.singer = @"铃声";
    music.url = @"http://lx.cdn.baidupcs.com/file/c6ea99ed89c407fe838d680ce5312547?bkt=p2-nj-748&xcode=00e6db40ccb1594cd0edc013fcd7655704eea9dfc468c0be7f42c5f191c19e11&fid=4232889411-250528-747800813108916&time=1435739497&sign=FDTAXERLBH-DCb740ccc5511e5e8fedcff06b081203-xoquLKIHtw%2FdWvdpnj9PEpYdaaE%3D&to=sc&fm=Nan,B,T,t&sta_dx=0&sta_cs=794&sta_ft=mp3&sta_ct=6&fm2=Nanjing,B,T,t&newver=1&newfm=1&secfm=1&flow_ver=3&sl=78118988&expires=8h&rt=sh&r=119779875&mlogid=2184345666&vuk=3843669578&vbdid=4035977607&fin=%E8%8B%B9%E6%9E%9C%20-%201%20-%20Iphone%20%E6%89%8B%E6%9C%BA%E7%9F%AD%E4%BF%A1%20%E5%B9%BF%E5%91%8A%E9%93%83%E5%A3%B0.mp3&fn=%E8%8B%B9%E6%9E%9C%20-%201%20-%20Iphone%20%E6%89%8B%E6%9C%BA%E7%9F%AD%E4%BF%A1%20%E5%B9%BF%E5%91%8A%E9%93%83%E5%A3%B0.mp3&slt=pm&uta=0&rtype=1&iv=0";
    
    MusicModel *music1 = [MusicModel new];
    music1.name = @"匆匆那年";
    music1.singer = @"王菲";
    music1.url = @"http://yinyueshiting.baidu.com/data2/music/240885332/124380645248400128.mp3?xcode=e55d21cc8ac811298c3c42cb27c397d9";
    
    MusicModel *music2 = [MusicModel new];
    music2.name = @"喜欢你";
    music2.singer = @"邓紫棋";
    music2.url = @"http://yinyueshiting.baidu.com/data2/music/239130183/12267411954000128.mp3?xcode=61143e7bc0ccb0c443e6e1d8249fc792";
    
    player = [[MyMusicPlayer alloc] initWithMusics:@[music,music1,music2]];
    
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
    [player stop];
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
