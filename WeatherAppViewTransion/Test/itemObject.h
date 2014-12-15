//
//  itemObject.h
//  Test
//
//  Created by Xiangjian Meng on 14/12/15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemObject : NSObject

- (instancetype)initWithTitle:(NSString *)title
                        color:(UIColor *)color;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *color;

@end
