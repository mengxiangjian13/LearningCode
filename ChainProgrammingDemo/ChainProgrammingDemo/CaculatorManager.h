//
//  CaculatorManager.h
//  ChainProgrammingDemo
//
//  Created by mengxiangjian on 16/3/10.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorManager : NSObject

@property (nonatomic, assign, readonly) float result;

// 加减乘除的block，接受一个数字，返回本类实例self
- (CaculatorManager *(^)(float num))add;
- (CaculatorManager *(^)(float num))sub;
- (CaculatorManager *(^)(float num))multi;
- (CaculatorManager *(^)(float num))divide;

@end
