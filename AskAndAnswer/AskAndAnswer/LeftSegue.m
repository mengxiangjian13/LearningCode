//
//  LeftSegue.m
//  AskAndAnswer
//
//  Created by Xiangjian Meng on 15/2/3.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "LeftSegue.h"
#import "JVFloatingDrawerViewController.h"

@implementation LeftSegue

- (void)perform
{
    [(JVFloatingDrawerViewController *)self.sourceViewController setLeftViewController:self.destinationViewController];
}

@end
