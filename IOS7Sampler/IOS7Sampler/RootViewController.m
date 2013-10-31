//
//  RootViewController.m
//  IOS7Sampler
//
//  Created by Xiangjian Meng on 13-10-22.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "RootViewController.h"
#import "DynamicBehaviorViewController.h"
#import "TransitioningViewController.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *titleNameArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // return navi delegate to nil because of transitioning view
    // very important or cause crash
    self.navigationController.delegate = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"catalogue";
    
	// Do any additional setup after loading the view.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    titleNameArray = [[NSArray alloc] initWithObjects:@"DynamicBehavior",@"TransitioningView", nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFontChanged)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)textFontChanged
{
    if (self.tableView) {
        [self.tableView reloadData];
    }
}


#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleNameArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [titleNameArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        DynamicBehaviorViewController *dynamicVC = [[DynamicBehaviorViewController alloc] init];
        dynamicVC.title = [titleNameArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:dynamicVC animated:YES];
    }
    else if (indexPath.row == 1)
    {
        TransitioningViewController *transitionVC = [[TransitioningViewController alloc] init];
        transitionVC.title = @"transitioning";
        [self.navigationController pushViewController:transitionVC animated:YES];
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Dynamic Text Font In This Page";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
