//
//  InterfaceController.m
//  WatchKitCatalog WatchKit Extension
//
//  Created by Xiangjian Meng on 14/11/25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "InterfaceController.h"
#import "InterfaceRowController.h"

@interface InterfaceController()
{
    NSArray *contentArray;
}

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;

@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        
        contentArray = [NSArray arrayWithObjects:@"Label",@"Button",@"Switch",@"Slider",
                                 @"Image",@"Separator",@"Map",@"Group",@"Table",@"Device",@"Controller",nil];
        
        [self.table setNumberOfRows:[contentArray count]
                        withRowType:@"RowController"];
        
        // 遍历所有的rowController添加title
        for (NSInteger i = 0; i < [self.table numberOfRows]; i ++)
        {
            id rowController = [self.table rowControllerAtIndex:i];
            if ([rowController isKindOfClass:[InterfaceRowController class]])
            {
                InterfaceRowController *rc = (InterfaceRowController *)rowController;
                [rc.label setText:contentArray[i]];
            }
        }
        
    }
    return self;
}

- (NSString *)actionForUserActivity:(NSDictionary *)userActivity context:(__autoreleasing id *)context
{
    // glance 进入后调用。
    // 返回值为页面的interfaceController的identifier,此identifier对应的页面将自动打开。
    return userActivity[@"interfaceIdentifier"];
}

// 处理远程通知
- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{
    // identifier是action的identifier
    // remoteNotification 是整个payload
    if ([identifier isEqualToString:@"OpenMap"])
    {
        [self pushControllerWithName:@"Map" context:nil];
    }
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    if (rowIndex >= 0 && rowIndex < [contentArray count])
    {
        NSString *identifier = contentArray[rowIndex];
        [self pushControllerWithName:identifier context:nil];
    }
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



