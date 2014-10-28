//
//  ViewController.m
//  NewCoreMotion
//
//  Created by Xiangjian Meng on 14/10/28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "ActivityModel.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
{
    CMMotionActivityManager *cmManager;
    NSMutableArray *validActivities;
    UITableView *tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    validActivities = [[NSMutableArray alloc] init];
    
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    cmManager = [[CMMotionActivityManager alloc] init];
    
    if ([CMMotionActivityManager isActivityAvailable])
    {
        // 历史记录
        NSTimeInterval interval = 24 * 3600;
        NSDate *startDate = [NSDate dateWithTimeIntervalSinceNow:-interval];
        
        __weak typeof(self) weakSelf = self;
        [cmManager queryActivityStartingFromDate:startDate
                                          toDate:[NSDate date]
                                         toQueue:[NSOperationQueue new]
                                     withHandler:^(NSArray *activities, NSError *error) {
                                         if (error == nil)
                                         {
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [weakSelf handleActivities:activities];
                                             });
                                         }
                                     }];
    }
    
}

- (void)handleActivities:(NSArray *)activities
{
    for (CMMotionActivity *activity in activities)
    {
        ActivityModel *model = [ActivityModel new];
        model.startDate = activity.startDate;
        if (activity.stationary)
        {
            model.type = ActivityModelTypeStationary;
            model.title = @"没动";
        }
        else if (activity.walking)
        {
            model.type = ActivityModelTypeWalking;
            model.title = @"走着";
            [self requestPedometerDataWithModel:model];
        }
        else if (activity.running)
        {
            model.type = ActivityModelTypeRunning;
            model.title = @"跑着";
            [self requestPedometerDataWithModel:model];
        }
        else if (activity.cycling)
        {
            model.type = ActivityModelTypeCycling;
            model.title = @"自行车";
        }
        else if (activity.automotive)
        {
            model.type = ActivityModelTypeAutomotive;
            model.title = @"汽车";
        }
        else
        {
            model.title = @"不知道";
        }
        
        [validActivities addObject:model];
    }
    
    [tableView reloadData];
}

- (void)requestPedometerDataWithModel:(ActivityModel *)model
{
    CMPedometer *pedometer = [[CMPedometer alloc] init];
    [pedometer queryPedometerDataFromDate:model.startDate
                                   toDate:model.startDate
                              withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                  NSString *pedometerString = @"";
                                  if ([CMPedometer isDistanceAvailable])
                                  {
                                      NSLengthFormatter *lengthFormatter = [[NSLengthFormatter alloc] init];
                                      NSString *length = [lengthFormatter stringFromValue:pedometerData.distance.doubleValue
                                                                                     unit:NSLengthFormatterUnitKilometer];
                                      pedometerString = [pedometerString stringByAppendingFormat:@"distance:%@",length];
                                  }
                                  if ([CMPedometer isStepCountingAvailable])
                                  {
                                      pedometerString = [pedometerString stringByAppendingFormat:@" | step:%d",pedometerData.numberOfSteps.intValue];
                                  }
                                  if ([CMPedometer isFloorCountingAvailable])
                                  {
                                      pedometerString = [pedometerString stringByAppendingFormat:@" | floor:%d",pedometerData.floorsAscended.intValue];
                                  }
                                  
                                  NSLog(@"%@",pedometerString);
                              }];
}

#pragma mark -
#pragma mark UITableViewDataSource UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [validActivities count];
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ActivityModel *model = [validActivities objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
