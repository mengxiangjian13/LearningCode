//
//  TableViewCell.m
//  StoryboardLearningProject
//
//  Created by Xiangjian Meng on 13-9-14.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize mainLabel,subLabel,imageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
