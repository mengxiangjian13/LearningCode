//
//  SecondController.m
//  AppleWatchDemo
//
//  Created by Xiangjian Meng on 14/11/24.
//  Copyright (c) 2014年 Xiangjian Meng. All rights reserved.
//

#import "SecondController.h"

@implementation SecondController

- (instancetype)initWithContext:(id)context
{
    self = [super initWithContext:context];
    
    if (self)
    {
        [self.label setText:context];
    }
    
    return self;
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}
@end
