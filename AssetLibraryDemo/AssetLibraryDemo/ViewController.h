//
//  ViewController.h
//  AssetLibraryDemo
//
//  Created by Xiangjian Meng on 15/3/10.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagePickerDelegate <NSObject>

- (void)imagePickerDidSelectImage:(UIImage *)image;

@optional
- (void)imagePickerCancelSelectImage;

@end

@interface ViewController : UIViewController

@property (nonatomic, weak) id <ImagePickerDelegate> delegate;

@end

