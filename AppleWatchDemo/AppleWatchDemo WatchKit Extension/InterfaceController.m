//
//  InterfaceController.m
//  AppleWatchDemo WatchKit Extension
//
//  Created by Xiangjian Meng on 14/11/23.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@end


@implementation InterfaceController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        NSLog(@"%@ initWithContext", self);
        [self.table setNumberOfRows:10 withRowType:@"myRowControllerType"];
        NSLog(@"row number:%ld",[self.table numberOfRows]);
    }
    return self;
}

- (IBAction)pushNewController:(id)sender
{
    ;
}

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex
{
    id rowController = [table rowControllerAtIndex:rowIndex];
    NSLog(@"%@",rowController);
    return [NSString stringWithFormat:@"row %ld",(long)rowIndex];
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



