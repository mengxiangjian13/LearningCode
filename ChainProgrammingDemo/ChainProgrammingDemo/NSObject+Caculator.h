//
//  NSObject+Caculator.h
//  ChainProgrammingDemo
//
//  Created by mengxiangjian on 16/3/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CaculatorManager.h"

/*
 此类的目的就是使用链式编程思想完成一个计算器
 备注，只是形式上的，按照顺序加减乘除，不考虑乘除优先级高的问题。
 */

@interface NSObject (Caculator)

/*
 实例式 链式编程。但在此使用不合适，因为只有一个实例，如果进行多个运算，产生的计算结果会冲突，也就是下个计算结果会加上上个计算结果。
 */
@property (nonatomic, strong, readonly) CaculatorManager *cManager;

/*
 静态方法式 链式编程。再次就显得合适多，因为一次调用内部只会创建一个 CaculatorManager 实例，每次计算都是独立的。
 */

+ (float)makeCaculator:(void(^)(CaculatorManager *manager))caculator;

@end
