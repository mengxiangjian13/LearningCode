//
//  DeviceInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "DeviceInterfaceController.h"

@interface DeviceInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *boundsLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scaleLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *localeLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *contentSizeLabel;

@end

@implementation DeviceInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        WKInterfaceDevice *device = [WKInterfaceDevice currentDevice];
        [self.boundsLabel setText:NSStringFromCGRect(device.screenBounds)];
        [self.scaleLabel setText:[NSString stringWithFormat:@"%.2f",device.screenScale]];
//        [self.localeLabel setText:[device.currentLocale localeIdentifier]];
        [self.contentSizeLabel setText:device.preferredContentSizeCategory];
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
