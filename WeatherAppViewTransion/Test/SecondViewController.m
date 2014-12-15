//
//  SecondViewController.m
//  Test
//
//  Created by Xiangjian Meng on 14/12/15.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
{
    NSMutableArray *itemArray;
    NSInteger currentIndex;
    UIScrollView *scrollView;
    NSMutableArray *viewArray;
}

@end

@implementation SecondViewController

- (instancetype)initWithItemArray:(NSArray *)array index:(NSInteger)index
{
    self = [super init];
    if (self)
    {
        itemArray = [[NSMutableArray alloc] initWithArray:array];
        currentIndex = index;
        viewArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(320, 568);
    scrollView.scrollEnabled = YES;
    scrollView.alwaysBounceVertical = YES;
    [self.view addSubview:scrollView];
    
    [self createItemsWithScrollView:scrollView];
    
    [self addShadowView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 100, 50);
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)createItemsWithScrollView:(UIScrollView *)_scrollView
{
    for (int i = 0; i < [itemArray count]; i ++)
    {
        ItemObject *item = itemArray[i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * i, scrollView.bounds.size.width, 60)];
        label.backgroundColor = item.color;
        label.textColor = [UIColor whiteColor];
        label.text = item.title;
        [_scrollView addSubview:label];
        [viewArray addObject:label];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
    }
}

- (void)tap:(id)sender
{
    UIGestureRecognizer *tap = (UIGestureRecognizer *)sender;
    UIView *view = [tap view];
    currentIndex = [viewArray indexOfObject:view];
    if (self.delegate && [self.delegate respondsToSelector:@selector(secondViewControllerDidSelectViewAtIndex:)])
    {
        [self.delegate secondViewControllerDidSelectViewAtIndex:currentIndex];
    }
    [self dismiss:nil];
}

- (void)addShadowView
{
    UIView *label = [viewArray lastObject];
    CGFloat originY = label.frame.origin.y + label.bounds.size.height;
    CGFloat height = self.view.bounds.size.height - originY;
    if (height > 0)
    {
        UIView *shadow = [[UIView alloc] initWithFrame:CGRectMake(0, originY, self.view.bounds.size.width, height)];
        shadow.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [scrollView addSubview:shadow];
        [viewArray addObject:shadow];
    }
}

- (void)showAnimationWithCompletion:(void(^)())compeltion
{
    UIView *view = [viewArray objectAtIndex:currentIndex];
    CGFloat top = - view.frame.origin.y;
    [viewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx <= currentIndex)
        {
            UIView *view = (UIView *)obj;
            view.transform = CGAffineTransformMakeTranslation(0, top);
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished) {
                if (idx == [viewArray count] - 1)
                {
                    compeltion();
                }
            }];
        }
        if (idx > currentIndex)
        {
            UIView *view = (UIView *)obj;
            view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height - view.frame.origin.y);
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformIdentity;
            }completion:^(BOOL finished) {
                if (idx == [viewArray count] - 1)
                {
                    compeltion();
                }
            }];
        }
    }];
}

- (void)dismissAnimationWithCompletion:(void(^)())compeltion
{
    UIView *view = [viewArray objectAtIndex:currentIndex];
    CGFloat top = - view.frame.origin.y;
    [viewArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (idx <= currentIndex)
        {
            UIView *view = (UIView *)obj;
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformMakeTranslation(0, top);
            }completion:^(BOOL finished) {
                if (idx == [viewArray count] - 1)
                {
                    compeltion();
                }
            }];
        }
        if (idx > currentIndex)
        {
            UIView *view = (UIView *)obj;
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height - view.frame.origin.y);
            }completion:^(BOOL finished) {
                if (idx == [viewArray count] - 1)
                {
                    compeltion();
                }
            }];
        }
    }];
}

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.transitioningDelegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
