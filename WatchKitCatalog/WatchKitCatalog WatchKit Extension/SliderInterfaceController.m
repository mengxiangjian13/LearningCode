//
//  SliderInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "SliderInterfaceController.h"

@interface SliderInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceSlider *coloredSlider;

@end

@implementation SliderInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self.coloredSlider setColor:[UIColor redColor]];
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
