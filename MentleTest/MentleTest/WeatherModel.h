//
//  WeatherModel.h
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/3.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface WeatherModel : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSNumber *temperature;

@end
