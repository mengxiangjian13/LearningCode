//
//  NSObject+Caculator.m
//  ChainProgrammingDemo
//
//  Created by mengxiangjian on 16/3/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "NSObject+Caculator.h"
#import <objc/runtime.h>

@implementation NSObject (Caculator)

- (CaculatorManager *)cManager {
    CaculatorManager *manager = objc_getAssociatedObject(self, _cmd);
    if (!manager) {
        manager = [CaculatorManager new];
        objc_setAssociatedObject(self, _cmd, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return manager;
}

+ (float)makeCaculator:(void(^)(CaculatorManager *manager))caculator {
    CaculatorManager *manager = [CaculatorManager new];
    caculator(manager);
    return manager.result;
}

@end
