//
//  DownloadHandler.m
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "DownloadHandler.h"

@interface DownloadHandler () <NSURLSessionDownloadDelegate>
{
    NSString *filePath;
    NSMutableArray *itemArray;
    NSURLSession *session;
    NSString *downloadDirectory;
}

@end

@implementation DownloadHandler

+ (instancetype)sharedHandler
{
    static DownloadHandler *hander = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hander = [DownloadHandler new];
    });
    return hander;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                delegate:self
                                           delegateQueue:nil];
    }
    return self;
}

- (void)start
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [cachePath stringByAppendingString:@"/download.plist"];
    downloadDirectory = [cachePath stringByAppendingString:@"/downloadAudios"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:downloadDirectory])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    itemArray = [NSMutableArray new];
    NSArray *arr = [[NSArray alloc] initWithContentsOfFile:filePath];
    if (arr)
    {
        for (NSDictionary *dict in arr)
        {
            DownloadItem *item = [self itemWithDict:dict];
            if (item)
            {
                [itemArray addObject:item];
            }
        }
    }
}

- (NSArray *)downloadItemList
{
    return itemArray;
}

- (void)addDownloadTaskWithItem:(DownloadItem *)item sessionId:(NSUInteger *)sessionId
{
//    [itemArray addObject:item];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:item.url]];
    item.sessionId = task.taskIdentifier;
    item.downloaded = NO;
    [itemArray addObject:item];
    
    *sessionId = task.taskIdentifier;
    
    [task resume];
}

- (void)startDownloadTaskWithItem:(DownloadItem *)item sessionId:(NSUInteger *)sessionId
{
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:[NSURL URLWithString:item.url]];
    item.sessionId = task.taskIdentifier;
    *sessionId = task.taskIdentifier;
    
    [task resume];
}

- (void)resumeDownloadTaskWithSessionId:(NSUInteger)sessionId
{
    [session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDownloadTask *task in downloadTasks)
        {
            if (task.taskIdentifier == sessionId)
            {
                [task resume];
            }
        }
    }];
}

- (void)pauseDownloadTaskWithSessionId:(NSUInteger)sessionId
{
    
}

- (void)synchronize
{
    NSMutableArray *arr = [NSMutableArray new];
    for (DownloadItem *item  in itemArray)
    {
        NSDictionary *dict = [self dictWithItem:item];
        if (dict)
        {
            [arr addObject:dict];
        }
    }
    [arr writeToFile:filePath atomically:YES];
}

#pragma mark -
- (NSDictionary *)dictWithItem:(DownloadItem *)item
{
    if (!item.url)
    {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    if (item.url)
    {
        [dict setObject:item.url forKey:@"url"];
    }
    [dict setObject:@(item.downloaded) forKey:@"state"];
    if (item.savedName)
    {
        [dict setObject:item.savedName forKey:@"name"];
    }
    
    return dict;
}

- (DownloadItem *)itemWithDict:(NSDictionary *)dict
{
    if (!dict[@"url"])
    {
        return nil;
    }
    
    DownloadItem *item = [[DownloadItem alloc] initWithUrl:dict[@"url"]];
    
    if (dict[@"state"])
    {
        NSNumber *num = dict[@"state"];
        item.downloaded = [num boolValue];
    }
    
    if (dict[@"name"])
    {
        item.savedName = dict[@"name"];
    }
    
    return item;
}

- (DownloadItem *)itemWithSessionId:(NSUInteger)dId
{
    for (DownloadItem *item in itemArray)
    {
        if (item.sessionId == dId)
        {
            return item;
        }
    }
    
    return nil;
}

#pragma mark - download task delegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    DownloadItem *item = [self itemWithSessionId:downloadTask.taskIdentifier];
    if (item)
    {
        item.downloaded = YES;
        NSString *name = [item.url lastPathComponent];
        NSString *path = [downloadDirectory stringByAppendingFormat:@"/%@",name];
        item.savedName = path;
        item.sessionId = 0;
    }
    
    if (self.downloadedBlock)
    {
        self.downloadedBlock(downloadTask.taskIdentifier);
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    CGFloat progress = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
    
    DownloadItem *item = [self itemWithSessionId:downloadTask.taskIdentifier];
    item.progress = progress;
    
    if (self.downloadingBlock)
    {
        self.downloadingBlock(downloadTask.taskIdentifier, progress);
    }
}

@end
