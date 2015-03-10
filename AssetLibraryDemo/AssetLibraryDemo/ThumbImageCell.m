//
//  ThumbImageCell.m
//  AssetLibraryDemo
//
//  Created by Xiangjian Meng on 15/3/10.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ThumbImageCell.h"

@implementation ThumbImageCell

- (void)setImage:(UIImage *)image
{
    _image = image;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if (self.image)
    {
        [self.image drawInRect:rect];
    }
}


@end
