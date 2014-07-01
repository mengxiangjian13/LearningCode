//
//  DetailViewController.h
//  MultiSectionCollectionView
//
//  Created by Xiangjian Meng on 14-7-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UICollectionViewController


@property (nonatomic,strong) UIColor *color;
@property (nonatomic,assign) NSInteger itemCount;
@property (nonatomic,assign) NSInteger selectItemIndex;

@end
