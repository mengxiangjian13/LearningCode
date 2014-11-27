//
//  GlanceController.m
//  WatchKitCatalog WatchKit Extension
//
//  Created by Xiangjian Meng on 14/11/25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *image;

@end


@implementation GlanceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        UIImage *aImage = [UIImage imageNamed:@"42mm-Walkway"];
        if ([[WKInterfaceDevice currentDevice] screenBounds].size.width <= 136.0)
        {
            aImage = [UIImage imageNamed:@"38mm-Walkway"];
        }
        [self.image setImage:aImage];
        
        // glance不可以交互，点击任何地方都会进入watch app。
        // 但可以携带一些信息进入watch app，用如下方法。
        [self updateUserActivity:@"cn.com.modernmedia.WatchKitCatalog"
                        userInfo:@{@"interfaceIdentifier":@"Image"}];
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end



