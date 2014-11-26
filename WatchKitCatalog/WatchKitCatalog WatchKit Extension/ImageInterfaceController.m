//
//  ImageInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ImageInterfaceController.h"

@interface ImageInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceImage *staticImage;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *animationImage;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;

@end

@implementation ImageInterfaceController

- (instancetype)initWithContext:(id)context
{
    self = [super initWithContext:context];
    if (self)
    {
        
        NSData *imageData = nil;
        if ([[WKInterfaceDevice currentDevice] screenBounds].size.width > 136.0)
        {
            imageData = UIImagePNGRepresentation([UIImage imageNamed:@"42mm-Walkway"]);
        }
        else
        {
            imageData = UIImagePNGRepresentation([UIImage imageNamed:@"38mm-Walkway"]);
        }
        
        [self.staticImage setImageData:imageData];
    }
    return self;
}

- (IBAction)play:(id)sender
{
    [self.animationImage setImageNamed:@"Bus"];
    [self.animationImage startAnimating];
}

- (IBAction)stop:(id)sender
{
    [self.animationImage stopAnimating];
    [self.animationImage setImageNamed:@"Bus0"];
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
