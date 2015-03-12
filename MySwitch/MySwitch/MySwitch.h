//
//  MySwitch.h
//  MySwitch
//
//  Created by Xiangjian Meng on 15/3/12.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySwitch : UIView

@property (nonatomic, assign) BOOL on;

@property (nonatomic, strong) UIColor *onTitleColor;
@property (nonatomic, strong) UIColor *offTitleColor;

@property (nonatomic, strong) NSString *onTitle;
@property (nonatomic, strong) NSString *offTitle;

- (instancetype)initWithDrawingPoint:(CGPoint)point;

@end
