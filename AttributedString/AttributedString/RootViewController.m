//
//  RootViewController.m
//  AttributedString
//
//  Created by Xiangjian Meng on 13-11-13.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    CGPoint touchCenter;
    CGPoint moveCenter;
}

@end

@implementation RootViewController
@synthesize mainLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    mainLabel = [[UITextView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20)];
    mainLabel.backgroundColor = [UIColor redColor];
    mainLabel.font = [UIFont systemFontOfSize:50.0];
    mainLabel.textColor = [UIColor blackColor];
    [self.view addSubview:mainLabel];
    [self setText:@"我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的我们都没看的地方的可积分打开可怜的快乐到家看得见绿壳蛋鸡考虑到减肥绿壳蛋鸡可怜的"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    imageView.image = [UIImage imageNamed:@"logo"];
    imageView.userInteractionEnabled = YES;
    [mainLabel addSubview:imageView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [imageView addGestureRecognizer:pan];
    
}

- (void)setText:(NSString *)text
{
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:text];
    

    NSInteger strLength = [text length];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:25];
    [attriString addAttribute:NSParagraphStyleAttributeName
                      value:style
                      range:NSMakeRange(0, strLength)];
    
    
    mainLabel.attributedText = attriString;
    
}


- (void)pan:(UIGestureRecognizer *)pan
{
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        touchCenter = [pan locationInView:mainLabel];
        
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        moveCenter = [pan locationInView:mainLabel];
        
        CGFloat x = moveCenter.x - touchCenter.x;
        CGFloat y = moveCenter.y - touchCenter.y;
        
        CGPoint center = [[pan view] center];
        center.x += x;
        center.y += y;
        [[pan view] setCenter:center];
        
        touchCenter = [pan locationInView:mainLabel];
        
        mainLabel.textContainer.exclusionPaths = @[[self translatedBezierPath:pan]];
    }
    
    
}

- (UIBezierPath *)translatedBezierPath:(UIGestureRecognizer *)gesture
{
    CGRect butterflyImageRect = [mainLabel convertRect:[gesture view].frame fromView:mainLabel];
    UIBezierPath *newButterflyPath = [UIBezierPath bezierPathWithRect:butterflyImageRect];
    
    return newButterflyPath;
}

-(void)dealloc
{
    self.mainLabel = nil;
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
