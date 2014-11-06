//
//  Car.m
//  Runtime
//
//  Created by Xiangjian Meng on 14/11/6.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "Car.h"
#import "Animal.h"
#include <objc/runtime.h>

void dynamicMethod(id self,SEL _cmd)
{
    NSLog(@"动态方法实现");
}

@interface Car ()
{
    Animal *dog;
}

@end

@implementation Car

-(instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSLog(@"self:%@",[self class]);
        NSLog(@"super:%@",[super class]);
        dog = [[Animal alloc] init];
    }
    
    return self;
}

// 是否动态方法实现，在本类或者父类中都没有这个方法的实现，就会走到这里。
// return YES,相当于消息被拦截了,可以在runtime更换方法实现.处理就处理了，没处理就没有了。
// 所以可以动态添加实例方法。
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(resolveThisMethodDynamically))
    {
        class_addMethod([self class], sel, (IMP) dynamicMethod, "v@:");
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

// 同上，可以添加类方法。
+ (BOOL)resolveClassMethod:(SEL)sel
{
    return [super resolveClassMethod:sel];
}

// 消息重定向。就是把消息重定向给其他对象，让其他对象接收这个消息。
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    
    if ([dog respondsToSelector:aSelector])
    {
        return dog;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

// 消息转发 methodSignatureForSelector 是在验证消息是不是有效，如果有效（即对象实现了selector），就继续转发
// 过程。如果没有实现，即返回nil，随即崩溃。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *sig;
    
    sig = [dog methodSignatureForSelector:aSelector];
    
    return sig;
}

// 转发具体方法。这个方法其实有很强的灵活性，处理所有的转发消息。
// 处理的方式有多种，可以拦截不发送。可以转发。甚至可以不转发传进来的selector而去触发另一个selector。
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation invokeWithTarget:dog];// 将消息转发给dog
}

@end


