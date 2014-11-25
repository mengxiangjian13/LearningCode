//
//  ButtonDetailController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ButtonDetailController.h"

@interface ButtonDetailController ()
{
    BOOL currentHidden;
    CGFloat currentAlpha;
}

@property (weak, nonatomic) IBOutlet WKInterfaceButton *alphaChangeButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *button;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *hiddenButton;

- (IBAction)alphaChange:(id)sender;
- (IBAction)hiddenChange:(id)sender;

@end

@implementation ButtonDetailController

- (instancetype)initWithContext:(id)context
{
    self = [super initWithContext:context];
    
    if (self)
    {
        currentHidden = NO;
        currentAlpha = 1.0;
    }
    
    return self;
}

- (IBAction)alphaChange:(id)sender
{
    if (currentAlpha == 1.0)
    {
        currentAlpha = 0.0;
    }
    else
    {
        currentAlpha = 1.0;
    }
    
    [self.button setAlpha:currentAlpha];
}
- (IBAction)hiddenChange:(id)sender
{
    currentHidden = !currentHidden;
    
    [self.button setHidden:currentHidden];
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
