//
//  LeftViewController.m
//  AskAndAnswer
//
//  Created by Xiangjian Meng on 15/2/3.
//  Copyright (c) 2015年 com.mengxiangjian. All rights reserved.
//

#import "LeftViewController.h"
#import "JVFloatingDrawerViewController.h"

@interface LeftViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *columnTable;
    NSMutableArray *titles;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    titles = [NSMutableArray new];
    for (int i = 0; i < 20; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"这是第%d个栏目",i + 1];
        [titles addObject:str];
    }
    
    columnTable = [[UITableView alloc] initWithFrame:self.view.bounds
                                               style:UITableViewStylePlain];
    columnTable.delegate = self;
    columnTable.dataSource = self;
    columnTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    columnTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:columnTable];
    
    columnTable.contentInset = UIEdgeInsetsMake(80, 0, 0, 0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titles count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = titles[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if (rootVC && [rootVC isKindOfClass:[JVFloatingDrawerViewController class]])
    {
        JVFloatingDrawerViewController *vc = (JVFloatingDrawerViewController *)rootVC;
        [vc closeDrawerWithSide:JVFloatingDrawerSideLeft animated:YES completion:nil];
        
        UINavigationController *centerVC = (UINavigationController *)vc.centerViewController;
        UIViewController *rootVC = centerVC.viewControllers.firstObject;
        rootVC.title = titles[indexPath.row];
    }
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
