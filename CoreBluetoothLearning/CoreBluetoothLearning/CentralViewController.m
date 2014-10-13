//
//  CentralViewController.m
//  CoreBluetoothLearning
//
//  Created by Xiangjian Meng on 14-10-11.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "CentralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

#define kServiceID @"CA808299-5D00-4FF2-A543-53179220F64B"
#define kCharacteristicID @"DF8926E2-D146-4549-BADA-76097605307B"

@interface CentralViewController () <CBCentralManagerDelegate,CBPeripheralDelegate>
{
    CBCentralManager *centralManager;
    CBPeripheral *currentPeripheral;
    BOOL canScan;
}

@end

@implementation CentralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    CGFloat viewWidth = self.view.bounds.size.width;
        
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = CGPointMake(viewWidth / 2.0, 100);
    [button setTitle:@"寻找服务" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(searchService:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)searchService:(id)sender
{
    NSLog(@"寻找服务");
    
    if (canScan)
    {
        [centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:kServiceID]] options:@{CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
    }
}


#pragma mark -
#pragma mark CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
        {
            canScan = YES;
        }
            break;
            
        default:
        {
            NSLog(@"中央状态变化");
        }
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"发现周边");
    // 停止扫描
    [centralManager stopScan];
    
    // 连接周边
    if (peripheral != currentPeripheral)
    {
        currentPeripheral = peripheral;
        [centralManager connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    // 连接上周边
    currentPeripheral.delegate = self;
    
    // 周边去发现服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:kServiceID]]];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    // 发现服务
    for (CBService *service in peripheral.services)
    {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:kServiceID]])
        {
            [currentPeripheral discoverCharacteristics:@[[CBUUID UUIDWithString:kCharacteristicID]]
                                            forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    // 发现characteristic
    for (CBCharacteristic *cha in service.characteristics)
    {
        if ([cha.UUID isEqual:[CBUUID UUIDWithString:kCharacteristicID]])
        {
            // characteristic 通知
            [peripheral setNotifyValue:YES forCharacteristic:cha];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // charactristic 读取data
    [peripheral readValueForCharacteristic:characteristic];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    // 真正的data
//    characteristic.value
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
