//
//  ControllerInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ControllerInterfaceController.h"

@interface ControllerInterfaceController ()

@end

@implementation ControllerInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        ;
    }
    return self;
}

- (IBAction)presentNewController
{
    [self presentControllerWithNames:@[@"Presented",@"Presented",@"Presented",@"Presented",@"Presented"] contexts:@[@"first",@"second",@"third",@"forth",@"fifth"]];
    
}

- (IBAction)touchWhale
{
    NSLog(@"Look! A huge Whale!");
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
