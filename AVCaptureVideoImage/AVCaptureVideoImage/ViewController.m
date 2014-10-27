//
//  ViewController.m
//  AVCaptureVideoImage
//
//  Created by Xiangjian Meng on 14/10/27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()
{
    NSMutableArray *assets;
    ALAssetsLibrary *library;
    AVAsset *currentAsset;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    assets = [[NSMutableArray alloc] init];
    
    [self.slider addTarget:self action:@selector(changeSlider) forControlEvents:UIControlEventValueChanged];
    
    // library 最好是一直存活。这样asset才能访问url
    library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                               if (group)
                               {
                                   [group setAssetsFilter:[ALAssetsFilter allVideos]];
                                   NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
                                   [group enumerateAssetsAtIndexes:indexSet
                                                           options:0
                                                        usingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                                                            if (result)
                                                            {
                                                                // 正在遍历
                                                                [assets addObject:result];
                                                            }
                                                            else
                                                            {
                                                                // 完成遍历
                                                                [self captureVideoImageWithAssets:assets progress:self.slider.value];
                                                            }
                                                        }];
                               }
                           } failureBlock:^(NSError *error) {
                               NSLog(@"%@",error);
                           }];
    
}

- (void)captureVideoImageWithAssets:(NSMutableArray *)array progress:(CGFloat)progress
{
    if ([array count] > 0)
    {
        ALAsset *asset = [array objectAtIndex:0];
        NSURL *videoURL = asset.defaultRepresentation.url;
        if (videoURL)
        {
            AVAsset *avAsset = [AVAsset assetWithURL:videoURL];
            currentAsset = avAsset;
            AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:avAsset];
            Float64 durationSeconds = CMTimeGetSeconds([avAsset duration]);
            CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds * progress, 600);
            NSValue *value = [NSValue valueWithCMTime:midpoint];
            [generator generateCGImagesAsynchronouslyForTimes:@[value]
                                            completionHandler:^(CMTime requestedTime, CGImageRef image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error) {
                                                if (result == AVAssetImageGeneratorSucceeded)
                                                {
                                                    UIImage *uiImage = [UIImage imageWithCGImage:image];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        self.imageView.image = uiImage;
                                                    });
                                                }
                                            }];
        }
    }
}

- (void)changeSlider
{
    [self captureVideoImageWithAssets:assets progress:self.slider.value];
}

- (IBAction)exportVideo:(id)sender
{
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:currentAsset];
    if ([presets containsObject:AVAssetExportPresetLowQuality])
    {
        AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:currentAsset
                                                                         presetName:AVAssetExportPresetLowQuality];
        Float64 durationSeconds = CMTimeGetSeconds([currentAsset duration]);
        CMTime midpoint = CMTimeMakeWithSeconds(durationSeconds * self.slider.value, 600);
        Float64 zero = 0;
        CMTimeRange range = CMTimeRangeMake(CMTimeMake(zero, 600), midpoint);
        session.timeRange = range;
        session.outputFileType = AVFileTypeQuickTimeMovie;
        NSString *output = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        output = [output stringByAppendingString:@"/output.mp4"];
        session.outputURL = [NSURL fileURLWithPath:output];
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            switch (session.status)
            {
                case AVAssetExportSessionStatusCompleted:
                {
                    NSLog(@"导出成功 url:%@",currentAsset);
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
