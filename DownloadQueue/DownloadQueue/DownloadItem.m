//
//  DownloadItem.m
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "DownloadItem.h"

@implementation DownloadItem

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        _url = url;
    }
    return self;
}

@end
