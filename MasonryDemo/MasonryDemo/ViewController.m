//
//  ViewController.m
//  MasonryDemo
//
//  Created by Xiangjian Meng on 15/3/26.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "OrdinaryViewController.h"
#import "MultiViewController.h"
#import "CardViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titles;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    titles = @[@"普通",@"多视图",@"名片（复杂）"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:@"cell"];
    tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select row: %ld",indexPath.row);
    
    if (indexPath.row == 0)
    {
        OrdinaryViewController *vc = [OrdinaryViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1)
    {
        MultiViewController *mVC = [MultiViewController new];
        [self.navigationController pushViewController:mVC animated:YES];
    }
    else
    {
        CardViewController *cardVC = [CardViewController new];
        [self.navigationController pushViewController:cardVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
