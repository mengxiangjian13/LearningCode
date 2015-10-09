//
//  Person.h
//  SearchAPIDemo
//
//  Created by Xiangjian Meng on 15/10/9.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *personId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;

@end
