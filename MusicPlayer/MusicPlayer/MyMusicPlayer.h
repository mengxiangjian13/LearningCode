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

@protocol MyMusicPlayerDelegate <NSObject>

- (void)musicPlayerIsPlayingMusicAtIndex:(NSInteger)index;
- (void)musicPlayerIsPlayingWithProgress:(CGFloat)progress; // 0到1
- (void)musicPlayerIsPlayingAtSecond:(NSInteger)second;

@end

@interface MyMusicPlayer : NSObject

//- (instancetype)initWithMusics:(NSArray *)musics;

@property(nonatomic, weak) id <MyMusicPlayerDelegate> delegate;

- (void)playMusicWithMusics:(NSArray *)musics index:(NSInteger)index;

// 播放控制。
-(void) pause;
-(void) play;
-(void) clear; // 清理播放列表。
- (void)stop; // 停止。music停在当前歌曲。
- (void)previous;
- (void)next;
-(void) remoteControlReceivedWithEvent:(UIEvent *)receivedEvent;

// 切换歌曲
- (void)changeCurrentMusicToMusicWithIndex:(NSInteger)index;

@end
