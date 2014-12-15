//
//  SecondViewController.h
//  Test
//
//  Created by Xiangjian Meng on 14/12/15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemObject.h"

@protocol SecondViewControllerDelegate <NSObject>

- (void)secondViewControllerDidSelectViewAtIndex:(NSInteger)index;

@end

@interface SecondViewController : UIViewController

@property (nonatomic,weak) id <SecondViewControllerDelegate> delegate;

- (instancetype)initWithItemArray:(NSArray *)array index:(NSInteger)index;

- (void)showAnimationWithCompletion:(void(^)())compeltion;

- (void)dismissAnimationWithCompletion:(void(^)())compeltion;

@end
