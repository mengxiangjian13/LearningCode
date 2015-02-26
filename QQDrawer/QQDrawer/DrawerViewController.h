//
//  ViewController.h
//  QQDrawer
//
//  Created by Xiangjian Meng on 15/2/26.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftViewController;
@property (nonatomic, strong) UIViewController *centerViewController;

- (void)openLeftViewControllerWithComletionBlock:(void(^)(BOOL finish))completion;
- (void)closeLeftViewControllerWithComletionBlock:(void(^)(BOOL finish))completion;
- (void)toggleViewControllerWithComletionBlock:(void(^)(BOOL finish))completion;

@property (nonatomic, strong) UIImage *backgroundImage;

@end

