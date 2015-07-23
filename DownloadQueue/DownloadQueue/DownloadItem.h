//
//  DownloadItem.h
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface DownloadItem : NSObject

- (instancetype)initWithUrl:(NSString *)url;

@property (nonatomic, assign) NSUInteger sessionId;
@property (nonatomic, strong, readonly) NSString *url;
@property (nonatomic, assign) BOOL downloaded;
@property (nonatomic, strong) NSString *savedName;
@property (nonatomic, assign) CGFloat progress;

@end
