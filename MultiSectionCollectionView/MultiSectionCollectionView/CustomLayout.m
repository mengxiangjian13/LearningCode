//
//  CustomLayout.m
//  MultiSectionCollectionView
//
//  Created by Xiangjian Meng on 14-7-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "CustomLayout.h"

@implementation CustomLayout

- (id)init
{
    self = [super init];
    if (self)
    {
        self.itemSize = CGSizeMake(50, 50);
        self.sectionInset = UIEdgeInsetsMake(6, 6, 6, 6);
    }
    return self;
}

@end
