//
//  ViewController.h
//  AVMediaCapture
//
//  Created by Xiangjian Meng on 14-10-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UIView *scanView;
@property (weak, nonatomic) IBOutlet UIButton *openURLButton;

- (IBAction)stopScan:(id)sender;
- (IBAction)openURL:(id)sender;

@end

