//
//  SwitchInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "SwitchInterfaceController.h"

@interface SwitchInterfaceController ()

- (IBAction)switchAction:(BOOL)on;
@property (weak, nonatomic) IBOutlet WKInterfaceSwitch *offSwitch;
@property (weak, nonatomic) IBOutlet WKInterfaceSwitch *actionSwitch;

@end

@implementation SwitchInterfaceController

- (instancetype)initWithContext:(id)context
{
    self = [super initWithContext:context];
    if (self)
    {
        [self.offSwitch setOn:NO];
    }
    return self;
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

- (IBAction)switchAction:(BOOL)on
{
    NSLog(@"action switch is : %d",on);
}

@end
