//
//  ViewController.m
//  DownloadSessionDemo
//
//  Created by Xiangjian Meng on 15/7/4.
//  Copyright (c) 2015年 Xiangjian Meng. All rights reserved.
//

#import "ViewController.h"

#define kURL @"url"
#define kIdentifier @"identifier"
#define kFinish @"finish"

@interface ViewController () <NSURLSessionDownloadDelegate>
{
    NSURLSession *session;
    
    NSMutableArray *taskArray;
    NSMutableDictionary *downloadTaskDict;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    taskArray = [NSMutableArray new];
    downloadTaskDict = [NSMutableDictionary new];
    
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                            delegate:self
                                       delegateQueue:nil];
}


- (NSMutableDictionary *)taskWithURL:(NSString *)url
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:url,kURL,@0,kFinish, nil];
}

- (void)downLoadWithIndex:(NSInteger)index
{
    NSMutableDictionary *task = [taskArray objectAtIndex:index];
    NSString *url = [task objectForKey:@"url"];
    if (url)
    {
        NSURLSessionDownloadTask *_task = [session downloadTaskWithURL:[NSURL URLWithString:url]];
        
        [task setObject:@(_task.taskIdentifier) forKey:kIdentifier];
        [_task resume];
        
        [downloadTaskDict setObject:_task forKey:@(index)];
    }
}

- (void)pauseWithIndex:(NSInteger)index
{
    if ([downloadTaskDict objectForKey:@(index)])
    {
        
    }
}


#pragma mark NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
