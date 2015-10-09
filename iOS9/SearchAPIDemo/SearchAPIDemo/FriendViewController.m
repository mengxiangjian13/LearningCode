//
//  FriendViewController.m
//  SearchAPIDemo
//
//  Created by Xiangjian Meng on 15/10/9.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

#import "FriendViewController.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface FriendViewController ()
{
    Person *currentPerson;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;

@end

@implementation FriendViewController

- (instancetype)initWithPerson:(Person *)person
{
    self = [super init];
    if (self)
    {
        currentPerson = person;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.nameLabel.text = currentPerson.name;
    self.avatarView.image = currentPerson.image;
    
    [self saveIndex];
}

- (void)saveIndex
{
    // 重点
    CSSearchableItemAttributeSet *set = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeImage];
    set.title = currentPerson.name;
    set.contentDescription = [NSString stringWithFormat:@"我的好朋友%@",currentPerson.name];
    set.thumbnailData = UIImagePNGRepresentation(currentPerson.image);
    CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:currentPerson.personId
                                                               domainIdentifier:@"com.mengxiangjian.SearchAPIDemo"
                                                                   attributeSet:set];
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item]
                                                   completionHandler:^(NSError * _Nullable error) {
                                                       
                                                   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
