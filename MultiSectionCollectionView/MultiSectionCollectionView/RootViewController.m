//
//  RootViewController.m
//  MultiSectionCollectionView
//
//  Created by Xiangjian Meng on 14-7-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    NSInteger sectionCount;
    NSMutableArray *itemCountArray;
}

@end

@implementation RootViewController

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
    
    sectionCount = 3;
    itemCountArray = [[NSMutableArray alloc] initWithObjects:@4,@5,@4, nil];
    
    [self.collectionView registerClass:[UICollectionViewCell class]
            forCellWithReuseIdentifier:@"cell"];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteItem)];
    
    self.navigationItem.rightBarButtonItems = @[deleteItem,addItem];
}

- (void)addItem
{
    //随机添加的section
    int randomSection = arc4random_uniform(sectionCount);
    NSInteger itemCount = [[itemCountArray objectAtIndex:randomSection] integerValue];
    //section 中item数量+1
    itemCount ++;
    [itemCountArray replaceObjectAtIndex:randomSection withObject:@(itemCount)];
    //插入新item
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:itemCount - 1 inSection:randomSection]]];
}

- (void)deleteItem
{
    //随机添加的section
    int randomSection = arc4random_uniform(sectionCount);
    NSInteger itemCount = [[itemCountArray objectAtIndex:randomSection] integerValue];
    if (itemCount == 0)
    {
        return;
    }
    //section 中item数量-1
    itemCount --;
    [itemCountArray replaceObjectAtIndex:randomSection withObject:@(itemCount)];
    //删除新item
    [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:itemCount inSection:randomSection]]];
}



#pragma mark -
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[itemCountArray objectAtIndex:section] integerValue];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:(indexPath.section == 0)? 1:0
                                                       green:(indexPath.section == 1)? 1:0
                                                        blue:(indexPath.section == 2)? 1:0
                                                       alpha:1.0];
    
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return sectionCount;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
