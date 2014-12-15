//
//  itemObject.m
//  Test
//
//  Created by Xiangjian Meng on 14/12/15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ItemObject.h"

@implementation ItemObject

- (instancetype)initWithTitle:(NSString *)title
                        color:(UIColor *)color
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.color = color;
    }
    return self;
}

@end
