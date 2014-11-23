//
//  InterfaceController.h
//  AppleWatchDemo WatchKit Extension
//
//  Created by Xiangjian Meng on 14/11/23.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;

@end
