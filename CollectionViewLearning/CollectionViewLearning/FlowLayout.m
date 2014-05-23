//
//  FlowLayout.m
//  CollectionViewLearning
//
//  Created by Xiangjian Meng on 14-5-23.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "FlowLayout.h"

@interface FlowLayout ()
{
    UIDynamicAnimator *dynamicAnimator;
}

@end


@implementation FlowLayout


- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.itemSize = CGSizeMake(90, 90);
        
        dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    }
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    CGSize contentSize = self.collectionView.contentSize;
    
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    
    if (dynamicAnimator.behaviors.count == 0)
    {
        [items enumerateObjectsUsingBlock:^(id <UIDynamicItem> obj, NSUInteger idx, BOOL *stop) {
            UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:obj attachedToAnchor:obj.center];
            
            behavior.length = 0.0f;
            behavior.damping = 0.8;
            behavior.frequency = 1.0;
            
            [dynamicAnimator addBehavior:behavior];
        }];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
        CGFloat yDistanceFromTouch = fabsf(touchLocation.y - springBehaviour.anchorPoint.y);
        CGFloat xDistanceFromTouch = fabsf(touchLocation.x - springBehaviour.anchorPoint.x);
        CGFloat scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0f;
        
        UICollectionViewLayoutAttributes *item = springBehaviour.items.firstObject;
        CGPoint center = item.center;
        if (delta < 0) {
            center.y += MAX(delta, delta*scrollResistance);
        }
        else {
            center.y += MIN(delta, delta*scrollResistance);
        }
        item.center = center;
        
        [dynamicAnimator updateItemUsingCurrentState:item];
    }];
    return NO;
}

@end