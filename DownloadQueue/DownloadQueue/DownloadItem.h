//
//  DownloadItem.h
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef enum{
    DownloadItemStateNotStart = 0,
    DownloadItemStateDownloading,
    DownloadItemStatePause,
    DownloadItemStateDownloaded,
}DownloadItemState;

@interface DownloadItem : NSObject

- (instancetype)initWithUrl:(NSString *)url userInfo:(id)userInfo;

@property (nonatomic, assign) NSUInteger sessionId;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, strong, readonly) id userInfo;
@property (nonatomic, assign) DownloadItemState state;
@property (nonatomic, strong) NSString *savedName;
@property (nonatomic, assign) CGFloat progress;

@end
