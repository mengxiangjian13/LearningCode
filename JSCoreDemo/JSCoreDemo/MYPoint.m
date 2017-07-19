//
//  MYPoint.m
//  JSCoreDemo
//
//  Created by mengxiangjian on 2017/3/20.
//  Copyright © 2017年 mengxiangjian. All rights reserved.
//

#import "MYPoint.h"

@implementation MYPoint

- (NSString *)description {
    return [NSString stringWithFormat:@"my point is x:%f, y:%f",self.x,self.y];
}

+ (MYPoint *)makeMYPointWithX:(float)x
                            y:(float)y {
    MYPoint *point = [MYPoint new];
    point.x = x;
    point.y = y;
    return point;
}

- (void)printPoint {
    NSLog(@"%@",[self description]);
}

@end
