//
//  DrawerView.m
//  QQDrawer
//
//  Created by Xiangjian Meng on 15/2/26.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "DrawerView.h"

@implementation DrawerView
@synthesize leftContainer,centerContainer,imageView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupContainers];
    }
    return self;
}

- (void)setupContainers
{
    imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    CGSize size = self.bounds.size;
    leftContainer = [[UIView alloc] initWithFrame:CGRectMake(- size.width, 0, size.width, size.height)];
    [self addSubview:leftContainer];
    
    centerContainer = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:centerContainer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
