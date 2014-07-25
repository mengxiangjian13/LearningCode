//
//  TableViewCell.m
//  TableViewCellAsynImageTest
//
//  Created by Xiangjian Meng on 14-7-25.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 44, 44)];
        [self.contentView addSubview:_avatarView];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
