//
//  SystemLogMessage.h
//  GCDWebServerDemo
//
//  Created by mengxiangjian on 16/6/17.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemLogMessage : NSObject

@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) id sender;
@property (nonatomic, strong) id messageText;
@property (nonatomic, assign) long long messageID;

+ (NSArray<SystemLogMessage *> *)allLogAfterTime:(double) time;

@end
