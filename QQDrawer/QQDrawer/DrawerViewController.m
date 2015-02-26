//
//  ViewController.m
//  QQDrawer
//
//  Created by Xiangjian Meng on 15/2/26.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "DrawerViewController.h"
#import "DrawerView.h"

@interface DrawerViewController ()
{
    BOOL opened;
    
    UITapGestureRecognizer *tapGesture;
}

@property (nonatomic,strong) DrawerView *drawerView;

@end

@implementation DrawerViewController

- (void)loadView
{
    self.drawerView = [[DrawerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

- (DrawerView *)drawerView
{
    return (DrawerView *)self.view;
}

- (void)setDrawerView:(DrawerView *)drawerView {
    self.view = drawerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
}

#pragma mark -
#pragma mark BackgroundImage
- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    
    self.drawerView.imageView.image = backgroundImage;
}

#pragma mark -
#pragma mark Set ViewControllers
- (void)setCenterViewController:(UIViewController *)centerViewController
{
    [self replaceViewController:self.centerViewController withViewController:centerViewController container:self.drawerView.centerContainer];
    _centerViewController = centerViewController;
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    [self replaceViewController:self.leftViewController withViewController:leftViewController container:self.drawerView.leftContainer];
    _leftViewController = leftViewController;
}

- (void)replaceViewController:(UIViewController *)sourceViewController withViewController:(UIViewController *)destinationViewController container:(UIView *)container {
    
    [sourceViewController willMoveToParentViewController:nil];
    [sourceViewController.view removeFromSuperview];
    [sourceViewController removeFromParentViewController];
    
    [self addChildViewController:destinationViewController];
    [container addSubview:destinationViewController.view];
    [destinationViewController didMoveToParentViewController:self];
}

#pragma mark -
#pragma mark Manage ViewControllers
- (void)openLeftViewControllerWithComletionBlock:(void(^)(BOOL finish))completion
{
    if (!opened)
    {
        [self toggleViewControllerWithComletionBlock:completion];
    }
}

- (void)closeLeftViewControllerWithComletionBlock:(void(^)(BOOL finish))completion
{
    if (opened)
    {
        [self toggleViewControllerWithComletionBlock:completion];
    }
}

- (void)toggleViewControllerWithComletionBlock:(void(^)(BOOL finish))completion
{
    [UIView animateWithDuration:0.7
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:9
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         if (opened)
                         {
                             self.drawerView.centerContainer.transform = CGAffineTransformIdentity;
                             self.drawerView.leftContainer.transform = CGAffineTransformIdentity;
                         }
                         else
                         {
                             CGAffineTransform centerTranslate = CGAffineTransformMakeTranslation(0.5 * self.drawerView.centerContainer.bounds.size.width, 0.0);
                             CGAffineTransform centerScale = CGAffineTransformMakeScale(0.7, 0.7);
                             self.drawerView.centerContainer.transform = CGAffineTransformConcat(centerScale, centerTranslate);
                             
                             self.drawerView.leftContainer.transform = CGAffineTransformMakeTranslation(self.drawerView.leftContainer.bounds.size.width, 0);
                         }
                     }
                     completion:^(BOOL finished) {
                         opened = !opened;
                         if (completion)
                         {
                             completion(finished);
                         }
                     }];
    
    if (opened)
    {
        [self removeGesture];
    }
    else
    {
        [self addGesture];
    }
}

#pragma mark -
#pragma mark Gesture
- (void)addGesture
{
    if (!tapGesture)
    {
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCenter)];
    }
    
    self.centerViewController.view.userInteractionEnabled = NO;
    [self.drawerView.centerContainer addGestureRecognizer:tapGesture];
}

- (void)removeGesture
{
    self.centerViewController.view.userInteractionEnabled = YES;
    [self.drawerView.centerContainer removeGestureRecognizer:tapGesture];
}

- (void)tapCenter
{
    [self closeLeftViewControllerWithComletionBlock:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
