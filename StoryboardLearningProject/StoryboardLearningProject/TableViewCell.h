//
//  TableViewCell.h
//  StoryboardLearningProject
//
//  Created by Xiangjian Meng on 13-9-14.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell


@property (nonatomic, strong) IBOutlet UILabel *mainLabel;
@property (nonatomic, strong) IBOutlet UILabel *subLabel;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
