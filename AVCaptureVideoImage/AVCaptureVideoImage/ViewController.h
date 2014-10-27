//
//  ViewController.h
//  AVCaptureVideoImage
//
//  Created by Xiangjian Meng on 14/10/27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *exportVideoButton;

- (IBAction)exportVideo:(id)sender;

@end

