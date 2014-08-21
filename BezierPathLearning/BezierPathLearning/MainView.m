//
//  MainView.m
//  BezierPathLearning
//
//  Created by Xiangjian Meng on 14-8-21.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "MainView.h"

@interface MainView ()
{
    NSInteger selectIndex;
}

@end

@implementation MainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"圆",@"矩形",@"椭圆",@"二元曲线",@"三元曲线"]];
        segment.frame = CGRectMake(20, 50, 280, 30);
        segment.selectedSegmentIndex = 0;
        [segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:segment];
        
    }
    return self;
}

- (void)change:(id)sender
{
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    
    selectIndex = segment.selectedSegmentIndex;
    
    // 重新调用drawRect
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIBezierPath *path = nil;
    
    if (selectIndex == 0)
    {
        // 圆
        path = [UIBezierPath bezierPathWithArcCenter:self.center radius:50 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    }
    else if (selectIndex == 1)
    {
        // 矩形
        path = [UIBezierPath bezierPathWithRect:CGRectMake(110, 234, 100, 100)];
    }
    else if (selectIndex == 2)
    {
        // 椭圆
        path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(85, 234, 150, 100)];
    }
    else if (selectIndex == 3)
    {
        // 二元曲线
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(85, 234)];
        [path addQuadCurveToPoint:CGPointMake(320 - 85, 234)controlPoint:CGPointMake(160, 0)];
    }
    else
    {
        // 三元曲线
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(85, 234)];
        [path addCurveToPoint:CGPointMake(320 - 85, 234)
                controlPoint1:CGPointMake(135, 0)
                controlPoint2:CGPointMake(185, 568)];
    }
    
//    path.lineWidth = 5;
    [[UIColor blackColor] setStroke];
    [[UIColor redColor] setFill];
    
    [path stroke];
    [path fill];
    
}


@end
