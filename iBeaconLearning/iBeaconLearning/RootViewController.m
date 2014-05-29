//
//  RootViewController.m
//  iBeaconLearning
//
//  Created by Xiangjian Meng on 14-5-29.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreBluetooth/CoreBluetooth.h>

#define UUID @"3F466341-D829-42AD-AE82-96329B47BF35"

@interface RootViewController () <CLLocationManagerDelegate,CBPeripheralManagerDelegate>
{
    CLLocationManager *clManager;
    CLBeaconRegion *region;
    CBPeripheralManager *peripheraManager;
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
    
    //iBeacon定位也需要CLLocationManager
    clManager = [[CLLocationManager alloc] init];
    clManager.delegate = self;
    
    peripheraManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                               queue:dispatch_get_main_queue()];
    
    //还需要检测iBeacon的范围
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:UUID];
    region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                identifier:@"iBeacon"];
    
    UIButton *rangingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rangingButton.frame = CGRectMake(100, 100, 100, 50);
    [rangingButton addTarget:self action:@selector(rangeBeacon) forControlEvents:UIControlEventTouchUpInside];
    [rangingButton setTitle:@"ranging" forState:UIControlStateNormal];
    [self.view addSubview:rangingButton];
    
    UIButton *monitoringButton = [UIButton buttonWithType:UIButtonTypeSystem];
    monitoringButton.frame = CGRectMake(100, 200, 100, 50);
    [monitoringButton addTarget:self action:@selector(monitorBeacon) forControlEvents:UIControlEventTouchUpInside];
    [monitoringButton setTitle:@"monitoring" forState:UIControlStateNormal];
    [self.view addSubview:monitoringButton];
    
    UIButton *broadcastButton = [UIButton buttonWithType:UIButtonTypeSystem];
    broadcastButton.frame = CGRectMake(100, 300, 100, 50);
    [broadcastButton addTarget:self action:@selector(broadcast) forControlEvents:UIControlEventTouchUpInside];
    [broadcastButton setTitle:@"broadcast" forState:UIControlStateNormal];
    [self.view addSubview:broadcastButton];
    
    
}

- (void)rangeBeacon
{
    //此种检测一秒钟一次检测
    [clManager startRangingBeaconsInRegion:region];
}

- (void)monitorBeacon
{
    //此种检测几分钟一次；不能检测距离；同时只能最多检测20个region
    [clManager startMonitoringForRegion:region];
}

- (void)broadcast
{
    //广播自己，使自己成为一个beacon
    if(peripheraManager.state < CBPeripheralManagerStatePoweredOn) {
        NSLog(@"蓝牙没有打开");
        return;
    }
    
    //生成要广播的内容
    NSDictionary *payload = [region peripheralDataWithMeasuredPower:@-60];
    [peripheraManager startAdvertising:payload];
}

#pragma mark -
#pragma CLLocationManagerDelegate
//ranging方式检测代理方法
- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    //如果检测到了beacon，beacons参数数组中会有元素，元素的类型是CLBeacon
    if ([beacons count] > 0)
    {
        CLBeacon *beacon = [beacons objectAtIndex:0];
        
        NSLog(@"uuid:%@,major:%@,minor:%@",beacon.proximityUUID,beacon.major,beacon.minor);
        
        NSLog(@"accuracy:%ld,%f",(long)beacon.rssi,beacon.accuracy);
        
        switch (beacon.proximity)
        {
            case CLProximityUnknown:
            {
                NSLog(@"未知距离");
            }
                break;
            case CLProximityFar:
            {
                NSLog(@"距离较远");
            }
                break;
            case CLProximityNear:
            {
                NSLog(@"距离较近");
            }
                break;
            case CLProximityImmediate:
            {
                NSLog(@"距离很近");
            }
                break;
                
            default:
                break;
        }
        
    }
}

//monitoring 方式检测代理方法
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    //monitoring 检测到进入beacon范围
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    //monitoring 检测到退出beacon范围
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
