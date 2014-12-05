//
//  WeatherDetailModel.m
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/5.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "WeatherDetailModel.h"

@implementation WeatherDetailModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"desc" : @"description",
             @"main" : @"main"
             };
}

@end
