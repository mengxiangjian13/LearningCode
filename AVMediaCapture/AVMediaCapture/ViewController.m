//
//  ViewController.m
//  AVMediaCapture
//
//  Created by Xiangjian Meng on 14-10-17.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

/*
    扫描二维码
 */

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *session;
}

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self startScan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 实行Capture的设备。需要配置，比如MediaType，各种白平衡，聚焦，等.此处使用默认情况，具体可以看AVCaptureDevice.h
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus])
    {
        NSError *error = nil;
        if ([device lockForConfiguration:&error]) {
            // 自动对焦
            CGPoint autofocusPoint = CGPointMake(0.5f, 0.5f);// 在中心对焦
            [device setFocusPointOfInterest:autofocusPoint];
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            [device unlockForConfiguration];
        }
        
    }
    // 根据device创建input
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    // 根据input创建session
    session = [[AVCaptureSession alloc] init];
    if ([session canAddInput:input])
    {
        [session addInput:input];
    }
    
    // 创建获取二维码的putput
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    [session addOutput:output];// 需要session先添加output
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];// 定义output metadata为二维码数据
    
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    if (layer.connection.supportsVideoOrientation)
    {
        layer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    }
    
    
    [self.scanView.layer insertSublayer:layer atIndex:0];
}

- (IBAction)stopScan:(id)sender
{
    if (session && session.running)
    {
        [session stopRunning];
    }
}

- (void)startScan
{
    if (session && !session.running)
    {
        [session startRunning];
    }
}

#pragma mark - 
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 如果检测到
    for (id object in metadataObjects)
    {
        if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]])
        {
            AVMetadataMachineReadableCodeObject *readableObjeect = (AVMetadataMachineReadableCodeObject *)object;
            if (readableObjeect.type == AVMetadataObjectTypeQRCode)
            {
                NSString *qrCode = readableObjeect.stringValue;
                NSLog(@"找到二维码，二维码解码为：%@",qrCode);
                [self stopScan:nil];
                NSURL *url = [NSURL URLWithString:qrCode];
                if ([[UIApplication sharedApplication] canOpenURL:url])
                {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
