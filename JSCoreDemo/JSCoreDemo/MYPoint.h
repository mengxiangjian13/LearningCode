//
//  MYPoint.h
//  JSCoreDemo
//
//  Created by mengxiangjian on 2017/3/20.
//  Copyright © 2017年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@class MYPoint;

/*
 暴露OC给JS，可以访问类的属性，方法（包括实例方法和类方法）
 */
@protocol MYPointExport <JSExport>

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;

- (NSString *)description;
//+ (MYPoint *)makeMYPointWithX:(float)x
//                            y:(float)y;
JSExportAs(makePoint, + (MYPoint *)makeMYPointWithX:(float)x
           y:(float)y);
- (void)printPoint;

@end

@interface MYPoint : NSObject <MYPointExport>

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;

- (NSString *)description;
+ (MYPoint *)makeMYPointWithX:(float)x
                            y:(float)y;
- (void)printPoint;

@end
