//
//  ViewController.m
//  Test
//
//  Created by Xiangjian Meng on 14/12/15.
//  Copyright (c) 2014年 ;. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#import "CollectionViewCell.h"

@interface AnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation AnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *prensentedVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:prensentedVC.view];
    
    SecondViewController *sVC = (SecondViewController *)prensentedVC;
    [sVC showAnimationWithCompletion:^{
        [transitionContext completeTransition:YES];
    }];
}

@end

@interface AnimatedDismissTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@end

@implementation AnimatedDismissTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *prensentedVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:prensentedVC.view];

    SecondViewController *sVC = (SecondViewController *)prensentedVC;
    [sVC dismissAnimationWithCompletion:^{
        [transitionContext completeTransition:YES];
    }];
}

@end

@interface ViewController () <UIViewControllerTransitioningDelegate,SecondViewControllerDelegate>

- (IBAction)present:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = self.view.bounds.size;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (IBAction)present:(id)sender
{
    ItemObject *object1 = [[ItemObject alloc] initWithTitle:@"红色" color:[UIColor redColor]];
    ItemObject *object2 = [[ItemObject alloc] initWithTitle:@"蓝色" color:[UIColor blueColor]];
    ItemObject *object3 = [[ItemObject alloc] initWithTitle:@"黄色" color:[UIColor yellowColor]];
    UICollectionViewCell *cell = self.collectionView.visibleCells[0];
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    SecondViewController *sVC = [[SecondViewController alloc] initWithItemArray:@[object1,object2,object3] index:indexPath.item];
    sVC.transitioningDelegate = self;
    sVC.delegate = self;
    sVC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:sVC animated:YES completion:nil];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [AnimatedTransitioning new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [AnimatedDismissTransitioning new];
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                         forIndexPath:indexPath];
    switch (indexPath.item)
    {
        case 0:
        {
            cell.backgroundColor = [UIColor redColor];
        }
            break;
        case 1:
        {
            cell.backgroundColor = [UIColor blueColor];
        }
            break;
        case 2:
        {
            cell.backgroundColor = [UIColor yellowColor];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark -

- (void)secondViewControllerDidSelectViewAtIndex:(NSInteger)index
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
