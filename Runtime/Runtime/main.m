//
//  main.m
//  Runtime
//
//  Created by Xiangjian Meng on 14/11/6.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"
#include <objc/runtime.h>

void ShowMe(id self,SEL _cmd)
{
    NSLog(@"SHOW ME THE ERROR!");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Car *car = [[Car alloc] init];
        [car resolveThisMethodDynamically];
        [car fafafa];
        [car cacaca];
        
        // 动态生成类
        Class MyClass = objc_allocateClassPair([NSError class], "MyError", 0);
        class_addMethod(MyClass, @selector(showMe), (IMP) ShowMe, "v@:");
        objc_registerClassPair(MyClass);
        
        id error = [[MyClass alloc] init];
        [error performSelector:@selector(showMe)];
        
        
        
    }
    return 0;
}
