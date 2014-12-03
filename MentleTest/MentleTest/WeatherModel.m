//
//  WeatherModel.m
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/3.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"temperature" : @"main.temp"
             };
}

@end
