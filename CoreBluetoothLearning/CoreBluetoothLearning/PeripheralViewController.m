//
//  PeripheralViewController.m
//  CoreBluetoothLearning
//
//  Created by Xiangjian Meng on 14-10-11.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "PeripheralViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

// 在终端中利用 uuidgen 命令随机生成uuid
#define kServiceID @"CA808299-5D00-4FF2-A543-53179220F64B"
#define kCharacteristicID @"DF8926E2-D146-4549-BADA-76097605307B"

@interface PeripheralViewController () <CBPeripheralManagerDelegate>
{
    CBPeripheralManager *peripheralManager;
    BOOL canAdvertising;
}

@end

@implementation PeripheralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    CGFloat viewWidth = self.view.bounds.size.width;
    
    self.title = @"Central";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = CGPointMake(viewWidth / 2.0, 100);
    [button setTitle:@"广播服务" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(broadcastService:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)setupServices
{
    // 创建并添加服务
    
    // 先通过uuid创建characteristics
    CBUUID *cUUID = [CBUUID UUIDWithString:kCharacteristicID];
    CBMutableCharacteristic *chas = [[CBMutableCharacteristic alloc] initWithType:cUUID
                                                                      properties:CBCharacteristicPropertyNotify
                                                                           value:nil
                                                                     permissions:CBAttributePermissionsReadable];
    // 根据service uuid创建service 设置 characteristic
    CBUUID *sUUID = [CBUUID UUIDWithString:kServiceID];
    CBMutableService *services = [[CBMutableService alloc] initWithType:sUUID primary:YES];
    [services setCharacteristics:@[chas]];
    
    [peripheralManager addService:services];
}

/*
   CBCharacteristicPropertyNotify 是觉得这个characteristic怎么使用的。
 
 */

- (void)broadcastService:(id)sender
{
    if (canAdvertising)
    {
        [self setupServices];
    }
}


#pragma mark -
#pragma mark CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // 状态发生变化。可以根据peripheral的状态变化提醒用户，比如不能使用蓝牙的时候提示失败。
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
        {
            canAdvertising = YES;
        }
            break;
            
        default:
        {
            NSLog(@"周边状态变化");
        }
            break;
    }
}

// 周边已经添加了服务，可以进行广播了。
- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
{
    if (!error)
    {
        [peripheralManager startAdvertising:
         
         @{ CBAdvertisementDataLocalNameKey :
         
         @"ICServer", CBAdvertisementDataServiceUUIDsKey :
         
         @[[CBUUID UUIDWithString:kServiceID]] }];
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
