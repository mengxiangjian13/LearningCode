//
//  UIImageView+Custom.m
//  AssociatedObject
//
//  Created by yizelin on 14-2-19.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "UIImageView+Custom.h"
#import <objc/runtime.h>

@implementation UIImageView (Custom)
@dynamic associatedObject;

//关联object，取@selector为唯一key。
- (void)setAssociatedObject:(id)associatedObject
{
    //set 一个相当于 nonatomic strong 的属性。
    objc_setAssociatedObject(self, @selector(associatedObject), associatedObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObject
{
    //get 属性。
    return objc_getAssociatedObject(self, @selector(associatedObject));
}

@end
