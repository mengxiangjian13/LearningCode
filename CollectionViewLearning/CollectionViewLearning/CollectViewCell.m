//
//  CollectViewCell.m
//  CollectionViewLearning
//
//  Created by Xiangjian Meng on 14-5-22.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "CollectViewCell.h"

@implementation CollectViewCell
@synthesize titleLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleLabel];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
