//
//  CaculatorManager.m
//  ChainProgrammingDemo
//
//  Created by mengxiangjian on 16/3/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "CaculatorManager.h"

@implementation CaculatorManager

- (instancetype)init {
    self = [super init];
    if (self) {
        _result = 0;
    }
    return self;
}

- (CaculatorManager *(^)(float num))add {
    __weak typeof(self) weakSelf = self;
    return ^(float num) {
        _result += num;
        return weakSelf;
    };
}

- (CaculatorManager *(^)(float num))sub {
    __weak typeof(self) weakSelf = self;
    return ^(float num) {
        _result -= num;
        return weakSelf;
    };
}

- (CaculatorManager *(^)(float num))multi {
    __weak typeof(self) weakSelf = self;
    return ^(float num) {
        _result *= num;
        return weakSelf;
    };
}

- (CaculatorManager *(^)(float num))divide {
    __weak typeof(self) weakSelf = self;
    return ^(float num) {
        _result /= num;
        return weakSelf;
    };
}


@end
