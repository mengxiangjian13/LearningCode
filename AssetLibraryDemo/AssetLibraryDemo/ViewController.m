//
//  ViewController.m
//  AssetLibraryDemo
//
//  Created by Xiangjian Meng on 15/3/10.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ThumbImageCell.h"
#import "PictureViewController.h"

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    ALAssetsLibrary *library;
    UICollectionView *mainCollectionView;
    NSMutableArray *assets;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (self.view.bounds.size.width - 35.0) / 4.0;
    flowLayout.itemSize = CGSizeMake(width, width);
    flowLayout.minimumInteritemSpacing = 0.0;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 10, 0, 10);
    
    
    CGSize size = self.view.bounds.size;
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height - 44)
                                                          collectionViewLayout:flowLayout];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    
    [self.view addSubview:mainCollectionView];
    
    [self addTakePhotoButtonWithFrame:CGRectMake(0, size.height - 44, size.width, 44)];
    
    [mainCollectionView registerClass:[ThumbImageCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 获取资源
    [self fetchAssets];
    
    assets = [NSMutableArray new];
}

- (void)addTakePhotoButtonWithFrame:(CGRect)frame
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = frame;
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)takePhoto
{
    NSLog(@"照相");
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIImagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if (image)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerDidSelectImage:)])
        {
            [self.delegate imagePickerDidSelectImage:image];
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerCancelSelectImage)])
    {
        [self.delegate imagePickerCancelSelectImage];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -
#pragma mark private method

- (void)fetchAssets
{
    library = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups = [NSMutableArray new];
    
    __weak typeof(self) weakSelf = self;
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                               if (group)
                               {
                                   // 筛选只取照片
                                   [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                                   [groups addObject:group];
                               }
                               else
                               {
                                   // 完成遍历，继续遍历groups
                                   [weakSelf enumAssetGroups:groups];
                               }
                           } failureBlock:^(NSError *error) {
                               NSLog(@"没有权限");
                               
                               
                           }];
}

- (void)enumAssetGroups:(NSMutableArray *)groups
{
    for (ALAssetsGroup *group in groups)
    {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result)
            {
                [assets addObject:result];
            }
            else
            {
                // 完成遍历
                [self reloadData];
            }
        }];
    }
}

- (void)reloadData
{
    // 刷新页面
    [mainCollectionView reloadData];
}


#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [assets count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThumbImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell)
    {
        ALAsset *asset = assets[indexPath.item];
        cell.image = [UIImage imageWithCGImage:asset.thumbnail];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中cell
    ALAsset *asset = assets[indexPath.item];
    CGImageRef imageRef = [asset defaultRepresentation].fullScreenImage;
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    if (image)
    {
        PictureViewController *pVC = [[PictureViewController alloc] initWithImage:image];
        [self.navigationController pushViewController:pVC animated:YES];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(imagePickerDidSelectImage:)])
        {
            [self.delegate imagePickerDidSelectImage:image];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
