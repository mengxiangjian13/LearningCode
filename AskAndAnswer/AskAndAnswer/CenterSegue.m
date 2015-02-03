//
//  RightSegue.m
//  AskAndAnswer
//
//  Created by Xiangjian Meng on 15/2/3.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "CenterSegue.h"
#import "JVFloatingDrawerViewController.h"

@implementation CenterSegue

- (void)perform
{
    [(JVFloatingDrawerViewController *)self.sourceViewController setCenterViewController:self.destinationViewController];
}

@end
