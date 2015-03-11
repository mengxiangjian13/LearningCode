//
//  LabelDetailController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "LabelDetailController.h"

@interface LabelDetailController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *customLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceTimer *timer;

@end

@implementation LabelDetailController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Custom Text" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Light" size:12.0]}];
        [self.customLabel setAttributedText:string];
        // 设置计时器
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:10];
        [components setMonth:12];
        [components setYear:2015];
        [self.timer setDate:[[NSCalendar currentCalendar] dateFromComponents:components]];
        [self.timer setHidden:NO];
        [self.timer start];
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
