//
//  ViewController.m
//  JSCoreDemo
//
//  Created by mengxiangjian on 2017/3/20.
//  Copyright © 2017年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MYPoint.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     读取js代码
     read js code from main bundle
     */
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"jscore" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath
                                                   encoding:NSUTF8StringEncoding
                                                      error:nil];
    /*
     初始化context
     init jscontext
     */
    JSContext *context = [JSContext new];
    [context evaluateScript:jsString];
    
    /*
     给js添加方法，最简单的办法就是给context赋值block。
     但有两个坑：不要在block中直接使用JSValue和JSContext。因为block会强引用其中的
     变量，而JSValue又强引用JSContext，而block又运行在JSContext中，会造成引用循
     环
     */
    UIColor* (^block)(NSDictionary *dict) = ^(NSDictionary *dict) {
        float r = [dict[@"red"] floatValue];
        float g = [dict[@"green"] floatValue];
        float b = [dict[@"blue"] floatValue];
        return [UIColor colorWithRed:r/255.0
                               green:g/255.0
                                blue:b/255.0
                               alpha:1.0];
    };
    context[@"makeUIColor"] = block;
    
    /*
     调用js方法
     */
    JSValue *function = context[@"colorForWord"];
    JSValue *color = [function callWithArguments:@[@"blue"]];
    UIColor *uiColor = [color toObject];
    if ([uiColor isKindOfClass:[uiColor class]]) {
        self.view.backgroundColor = uiColor;
    }
    context[@"p"] = [MYPoint makeMYPointWithX:7 y:7];
    JSValue *pointFunction = context[@"makeAPoint"];
    [pointFunction callWithArguments:@[]];    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
