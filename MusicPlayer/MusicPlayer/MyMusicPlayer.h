//
//  MyMusicPlayer.h
//  MusicPlayer
//
//  Created by Xiangjian Meng on 15/7/1.
//  Copyright (c) 2015年 Boya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface MyMusicPlayer : NSObject

- (instancetype)initWithMusics:(NSArray *)musics;

// 播放控制。
-(void) pause;
-(void) play;
-(void) clear;
- (void)previous;
- (void)next;
-(void) remoteControlReceivedWithEvent:(UIEvent *)receivedEvent;

@end
