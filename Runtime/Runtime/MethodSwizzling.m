//
//  MethodSwizzling.m
//  Runtime
//
//  Created by Xiangjian Meng on 14/11/12.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "MethodSwizzling.h"
#include <objc/runtime.h>

@implementation MethodSwizzling

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL start = @selector(start);
        SEL swizzling = @selector(swizzling);
        
        Method startMethod = class_getInstanceMethod([self class], start);
        Method swizzlingMethod = class_getInstanceMethod([self class], swizzling);
        
        // 添加start方法，实现是swizzling实现，以此实现了方法实现的互换。但是在此例BOOL是NO，也就是方法添加不成功，因为本类已经有了start方法并且实现，所以添加start失败。
        // 如果start是父类方法，则添加可以成功
        BOOL addSuc = class_addMethod([self class], start, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
        if (addSuc)
        {
            // 如果添加成功，那就进行第二步，将swizzling改为start的实现
            class_replaceMethod([self class], swizzling, method_getImplementation(startMethod), method_getTypeEncoding(startMethod));
        }
        else
        {
            // 如果添加失败，则证明已经有了start方法，直接对调方法实现
            method_exchangeImplementations(startMethod, swizzlingMethod);
        }
        
    });
}

- (void)start
{
    NSLog(@"call the start eventually");
}

- (void)swizzling
{
    NSLog(@"start change to METHOD SWIZZLING!");
    [self swizzling];
}

@end
