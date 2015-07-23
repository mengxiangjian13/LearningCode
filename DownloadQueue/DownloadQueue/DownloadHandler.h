//
//  DownloadHandler.h
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import "DownloadItem.h"

@interface DownloadHandler : NSObject

@property (nonatomic, copy) void (^downloadingBlock)(NSUInteger sessionId, CGFloat progress);
@property (nonatomic, copy) void (^downloadedBlock)(NSUInteger sessionId);

+ (instancetype)sharedHandler;

- (void)start;

- (NSArray *)downloadItemList;

- (void)addDownloadTaskWithItem:(DownloadItem *)item sessionId:(NSUInteger *)sessionId;
- (void)startDownloadTaskWithItem:(DownloadItem *)item sessionId:(NSUInteger *)sessionId;

- (void)resumeDownloadTaskWithSessionId:(NSUInteger)sessionId;
- (void)pauseDownloadTaskWithSessionId:(NSUInteger)sessionId;

- (void)synchronize;

@end
