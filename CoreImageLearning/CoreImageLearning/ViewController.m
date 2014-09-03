//
//  ViewController.m
//  CoreImageLearning
//
//  Created by Xiangjian Meng on 14-9-3.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *imageView;
    CIContext *context;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:imageView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 500, 280, 30)];
    slider.value = 0.5;
    [self.view addSubview:slider];
    [slider addTarget:self action:@selector(changeIntensity:) forControlEvents:UIControlEventValueChanged];
    
    context = [CIContext contextWithOptions:nil];
    
    [self createImageWithIntensity:slider.value];
}

- (void)createImageWithIntensity:(CGFloat)intensity
{
    if (intensity < 0 || intensity > 1)
    {
        return;
    }
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"intro01-568@2x" withExtension:@"png"];
    CIImage *cImage = [[CIImage alloc] initWithContentsOfURL:url];
    
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"];
    [filter setValue:cImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:intensity] forKey:kCIInputIntensityKey];
    CIImage *oImage = filter.outputImage;
    
    CGImageRef ref = [context createCGImage:oImage fromRect:oImage.extent];
    UIImage *image = [UIImage imageWithCGImage:ref];
    imageView.image = image;
}

- (void)changeIntensity:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    
    [self createImageWithIntensity:slider.value];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
