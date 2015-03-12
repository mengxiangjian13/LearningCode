//
//  MySwitch.m
//  MySwitch
//
//  Created by Xiangjian Meng on 15/3/12.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "MySwitch.h"

@interface MySwitch ()

@property (nonatomic, strong) UIImageView *bImageView;
@property (nonatomic, strong) UIImageView *tImageView;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation MySwitch

- (instancetype)initWithDrawingPoint:(CGPoint)point
{
    self = [super initWithFrame:CGRectMake(point.x, point.y, 109, 34)];
    if (self)
    {
        _bImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 109, 34)];
        UIImage *bottomImage = [UIImage imageNamed:@"bottom"];
        UIImage *fitImage = [bottomImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, bottomImage.size.width / 2.0 - 1, 0, bottomImage.size.width / 2.0 + 1)];
        _bImageView.image = fitImage;
        [self addSubview:_bImageView];
        
        
        _tImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1.5, 60, 31)];
        UIImage *topImage = [UIImage imageNamed:@"top"];
        UIImage *topFitImage = [topImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, topImage.size.width / 2.0 - 1, 0, topImage.size.width / 2.0 + 1)];
        _tImageView.image = topFitImage;
        [self addSubview:_tImageView];

        
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 34)];
        _leftLabel.textColor = [UIColor whiteColor];
        _onTitleColor = [UIColor whiteColor];
        _leftLabel.text = @"关";
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_leftLabel];
        
        _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(49, 0, 60, 34)];
        _rightLabel.textColor = [UIColor redColor];
        _offTitleColor = [UIColor redColor];
        _rightLabel.text = @"开";
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_rightLabel];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)setOnTitle:(NSString *)onTitle
{
    _onTitle = onTitle;
    _rightLabel.text = onTitle;
}

- (void)setOnTitleColor:(UIColor *)onTitleColor
{
    _onTitleColor = onTitleColor;
    if (_on)
    {
        _rightLabel.textColor = onTitleColor;
    }
    else
    {
        _leftLabel.textColor = onTitleColor;
    }
    
}

- (void)setOffTitle:(NSString *)offTitle
{
    _offTitle = offTitle;
    _leftLabel.text = offTitle;
}

- (void)setOffTitleColor:(UIColor *)offTitleColor
{
    _offTitleColor = offTitleColor;
    if (_on)
    {
        _leftLabel.textColor = offTitleColor;
    }
    else
    {
        _rightLabel.textColor = offTitleColor;
    }
}


- (void)tap:(UIGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    if (point.x > 60)
    {
        // 开
        [self changeStateWithOn:YES];
    }
    else
    {
        // 关
        [self changeStateWithOn:NO];
    }
}

- (void)changeStateWithOn:(BOOL)on
{
    if (_on != on)
    {
        _on = on;
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             CGRect frame = _tImageView.frame;
                             if (_on)
                             {
                                 _leftLabel.textColor = _offTitleColor;
                                 _rightLabel.textColor = _onTitleColor;
                                 frame.origin.x = self.bounds.size.width - 59;
                             }
                             else
                             {
                                 frame.origin.x = 0;
                                 _leftLabel.textColor = _onTitleColor;
                                 _rightLabel.textColor = _offTitleColor;
                             }
                             _tImageView.frame = frame;
                         }];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
