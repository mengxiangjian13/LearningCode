//
//  PresentedInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "PresentedInterfaceController.h"

@interface PresentedInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *centerLabel;

@end

@implementation PresentedInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [self.centerLabel setText:[NSString stringWithFormat:@"%@ page",context]];
    }
    return self;
}

- (void)awakeWithContext:(id)context
{
    [self.centerLabel setText:[NSString stringWithFormat:@"%@ page",context]];
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
