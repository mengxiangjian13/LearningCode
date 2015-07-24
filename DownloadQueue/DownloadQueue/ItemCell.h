//
//  ItemCell.h
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemCellDelegate;

@interface ItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) id <ItemCellDelegate> delegate;

- (void)setButtonTitle:(NSString *)title;

@end

@protocol ItemCellDelegate <NSObject>

- (void)itemCellDidTouchPauseButtonWithCell:(ItemCell *)cell;

@end