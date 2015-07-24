//
//  ItemCell.m
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "ItemCell.h"

@interface ItemCell ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)pause:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(itemCellDidTouchPauseButtonWithCell:)])
    {
        [self.delegate itemCellDidTouchPauseButtonWithCell:self];
    }
}

- (void)setButtonTitle:(NSString *)title
{
    [self.button setTitle:title forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
