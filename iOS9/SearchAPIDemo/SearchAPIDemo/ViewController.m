//
//  ViewController.m
//  SearchAPIDemo
//
//  Created by Xiangjian Meng on 15/10/9.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "FriendViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *personArray;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    personArray = [NSMutableArray new];
    
    Person *becky = [self personWithName:@"becky"
                                personId:@"1"
                                   image:@"becky"];
    [personArray addObject:becky];
    
    Person *ben = [self personWithName:@"ben"
                                personId:@"2"
                                   image:@"ben"];
    [personArray addObject:ben];
    
    Person *jane = [self personWithName:@"jane"
                                personId:@"3"
                                   image:@"jane"];
    [personArray addObject:jane];
    
    Person *pete = [self personWithName:@"pete"
                                personId:@"4"
                                   image:@"pete"];
    [personArray addObject:pete];
    
    Person *ray = [self personWithName:@"ray"
                                personId:@"5"
                                   image:@"ray"];
    [personArray addObject:ray];
    
    Person *tom = [self personWithName:@"tom"
                                personId:@"6"
                                   image:@"tom"];
    [personArray addObject:tom];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)
                                                          style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (Person *)personWithName:(NSString *)name
                  personId:(NSString *)personId
                     image:(NSString *)imageName
{
    Person *person = [Person new];
    person.name = name;
    person.personId = personId;
    person.image = [UIImage imageNamed:imageName];
    
    return person;
}

#pragma mark - delegate datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [personArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    
    Person *person = personArray[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.imageView.image = person.image;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Person *person = personArray[indexPath.row];
    
    [self showPersonWithPersonId:person.personId];
}

- (void)showPersonWithPersonId:(NSString *)personId
{
    for (Person *person in personArray)
    {
        if ([person.personId isEqualToString:personId])
        {
            FriendViewController *vc = [[FriendViewController alloc] initWithPerson:person];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
