//
//  MapInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "MapInterfaceController.h"

@interface MapInterfaceController ()
{
    MKCoordinateSpan currentSpan;
    MKCoordinateRegion currentRegion;
}

@property (weak, nonatomic) IBOutlet WKInterfaceMap *map;

@end

@implementation MapInterfaceController

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        currentSpan = MKCoordinateSpanMake(1.0, 1.0);
        // 先定位到北京
        [self locateInBeijing];
    }
    return self;
}

//定位需要一个坐标和一个span（span就是以经纬度为单位的变动量）
- (IBAction)locateInApple
{
    CLLocationCoordinate2D apple = CLLocationCoordinate2DMake(37.331793f, -122.029584f);
    MKCoordinateRegion appleRegion = MKCoordinateRegionMake(apple, currentSpan);
    [self.map setRegion:appleRegion];
    currentRegion = appleRegion;
}

- (IBAction)locateInBeijing
{
    CLLocationCoordinate2D beijing = CLLocationCoordinate2DMake(40, 116);
    MKCoordinateRegion beijingRegion = MKCoordinateRegionMake(beijing, currentSpan);
    [self.map setRegion:beijingRegion];
    currentRegion = beijingRegion;
}

- (IBAction)zoomIn
{
    MKCoordinateSpan span = MKCoordinateSpanMake(currentSpan.latitudeDelta * 0.5, currentSpan.longitudeDelta * 0.5);
    currentSpan = span;
    currentRegion = MKCoordinateRegionMake(currentRegion.center, span);
    [self.map setRegion:currentRegion];
}

- (IBAction)zoomOut
{
    MKCoordinateSpan span = MKCoordinateSpanMake(currentSpan.latitudeDelta * 2.0, currentSpan.longitudeDelta * 2.0);
    currentSpan = span;
    currentRegion = MKCoordinateRegionMake(currentRegion.center, span);
    [self.map setRegion:currentRegion];
}

- (IBAction)pins
{
    [self.map addAnnotation:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude - 0.3) withPinColor:WKInterfaceMapPinColorRed];
    [self.map addAnnotation:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude) withPinColor:WKInterfaceMapPinColorGreen];
    [self.map addAnnotation:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude + 0.3) withPinColor:WKInterfaceMapPinColorPurple];
}

- (IBAction)imagePins
{
    [self.map addAnnotation:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude - 0.3) withImageNamed:@"Whale" centerOffset:CGPointZero];
    [self.map addAnnotation:CLLocationCoordinate2DMake(currentRegion.center.latitude, currentRegion.center.longitude + 0.3) withImage:[UIImage imageNamed:@"Bumblebee"]centerOffset:CGPointZero];
}

- (IBAction)removePins
{
    [self.map removeAllAnnotations];
}


- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
