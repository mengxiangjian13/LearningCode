//
//  ActionRequestHandler.m
//  QRCodeReader
//
//  Created by Xiangjian Meng on 14/10/19.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ActionRequestHandler.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreImage/CoreImage.h>

@interface ActionRequestHandler ()

@property (nonatomic, strong) NSExtensionContext *extensionContext;

@end

@implementation ActionRequestHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    // Do not call super in an Action extension with no user interface
    self.extensionContext = context;
    
    BOOL found = NO;
    
    // Find the item containing the results from the JavaScript preprocessing.
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(id object, NSError *error) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        if (object && [object isKindOfClass:[NSURL class]])
                        {
                            // 获取图片路径。
                            NSURL *fileURL = (NSURL *)object;
                            [self readQRCodeFromImageWithFileURL:fileURL];
                        }
                    }];
                }];
                found = YES;
            }
            break;
        }
        
    }
}

- (void)readQRCodeFromImageWithFileURL:(NSURL *)url
{
    // 根据URL找到CIImage
    CIImage *image = [CIImage imageWithContentsOfURL:url];
    if (image)
    {
        // 创建CIDetector
        CIDetector *qrDetector = [CIDetector detectorOfType:CIDetectorTypeQRCode
                                                    context:[CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}]
                                                    options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
        NSArray *features = [qrDetector featuresInImage:image];
        if ([features count] > 0)
        {
            for (CIFeature *feature in features)
            {
                if (![feature isKindOfClass:[CIQRCodeFeature class]])
                {
                    continue;
                }
                
                CIQRCodeFeature *qrFeature = (CIQRCodeFeature *)feature;
                NSString *code = qrFeature.messageString;
                NSLog(@"content is ：%@",code);
            }
        }
    }
    
    [self.extensionContext completeRequestReturningItems:nil
                                       completionHandler:^(BOOL expired) {
                                           NSLog(@"没有反应，关闭");
                                       }];
    
}

@end
