//
//  DrawLineView.m
//  DrawLines
//
//  Created by Xiangjian Meng on 14-9-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "DrawLineView.h"

@interface PointModel : NSObject

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;

@end

@implementation PointModel



@end


@interface DrawLineView ()
{
    BOOL isStart;
    NSMutableArray *pointArray;
}

@end


@implementation DrawLineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        isStart = YES;
        self.backgroundColor = [UIColor whiteColor];
        pointArray = [[NSMutableArray alloc] init];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    if ([pointArray count] == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < [pointArray count] - 1; i ++)
    {
        PointModel *point1 = [pointArray objectAtIndex:i];
        PointModel *point2 = [pointArray objectAtIndex:i + 1];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
    }
    
    CGContextSetRGBStrokeColor(context, 208/255.f, 36/255.f, 36/255.f, 0.7);//红色
    
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1)
    {
        isStart = NO;
        UITouch *touch = [touches anyObject];
        CGPoint startPoint = [touch locationInView:self];
        
        PointModel *point = [[PointModel alloc] init];
        point.x = startPoint.x;
        point.y = startPoint.y;
        [pointArray addObject:point];
        
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    startPoint = moveToPoint;
//    [self addPoint:startPoint];
    
    UITouch *touch = [touches anyObject];
    [self addPoint:[touch locationInView:self]];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    isStart = YES;
    
    [pointArray removeAllObjects];
}

#pragma mark -
- (void)addPoint:(CGPoint)cPoint
{
    PointModel *point = [[PointModel alloc] init];
    point.x = cPoint.x;
    point.y = cPoint.y;
    [pointArray addObject:point];
}


@end
