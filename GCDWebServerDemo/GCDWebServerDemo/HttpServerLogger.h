//
//  HttpServerLogger.h
//  GCDWebServerDemo
//
//  Created by mengxiangjian on 16/6/17.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpServerLogger : NSObject

// 开启server
- (void)startServer;
// 关闭server
- (void)stopServer;

@end
