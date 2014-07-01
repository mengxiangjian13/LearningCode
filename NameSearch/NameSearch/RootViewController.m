//
//  RootViewController.m
//  NameSearch
//
//  Created by Xiangjian Meng on 14-7-1.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"
#import "pinyin.h"

@interface RootViewController () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *names;
    NSMutableArray *dataArray;
    NSArray *sortedKey;
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
    
    names = @[@"wang",@"fhca",@"hehah",@"hahah",@"James",@"好人",@"大人",@"ronaldo",];
    [self sort];
    
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[dataArray objectAtIndex:section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sortedKey objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return sortedKey;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
}

- (void)sort
{
    //将name以首字母分到字典中，以首字母为key，value是这个字母开头的name的数组
    NSMutableDictionary *nameDic = [[NSMutableDictionary alloc] init];
    for (NSString *name in names)
    {
         NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([name characterAtIndex:0])]uppercaseString];
        if ([nameDic objectForKey:singlePinyinLetter])
        {
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:[nameDic objectForKey:singlePinyinLetter]];
            [arr addObject:name];
            NSArray *sortArr = [arr sortedArrayUsingFunction:nickNameSort context:NULL];
            [nameDic setObject:sortArr forKey:singlePinyinLetter];
        }
        else
        {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            [arr addObject:name];
            [nameDic setObject:arr forKey:singlePinyinLetter];
        }
    }
    
    dataArray = [[NSMutableArray alloc] init];
    sortedKey = [[nameDic allKeys] sortedArrayUsingFunction:nickNameSort context:NULL];
    for (NSString *key in sortedKey)
    {
        [dataArray addObject:[nameDic objectForKey:key]];
    }
    
    
}

NSInteger nickNameSort(id name1, id name2, void *context)
{
    return  [name1 localizedCompare:name2];
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
