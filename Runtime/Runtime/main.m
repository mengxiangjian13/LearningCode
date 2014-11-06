//
//  main.m
//  Runtime
//
//  Created by Xiangjian Meng on 14/11/6.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Car *car = [[Car alloc] init];
        [car resolveThisMethodDynamically];
        [car fafafa];
        [car cacaca];
    }
    return 0;
}
