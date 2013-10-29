//
//  TransitioningViewController.h
//  IOS7Sampler
//
//  Created by Xiangjian Meng on 13-10-28.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    TransitioningStylePlain = 0,
    TransitioningStyleFade,
}TransitioningStyle;

@interface TransitioningViewController : UIViewController

@property (nonatomic ,assign) TransitioningStyle style;

@end
