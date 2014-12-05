//
//  WeatherModel.m
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/3.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "WeatherModel.h"
#import "WeatherDetailModel.h"

@implementation WeatherModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"temperature" : @"main.temp",
             @"sunrise" : @"sys.sunrise",
             @"detail" : @"weather"
             };
}

+ (NSValueTransformer *)sunriseJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^NSString *(NSNumber *number) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number integerValue]];
        return [formatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)detailJSONTransformer
{
    return [MTLValueTransformer transformerWithBlock:^NSArray *(NSArray *detals)
    {
        return [MTLJSONAdapter modelsOfClass:[WeatherDetailModel class] fromJSONArray:detals error:nil];
    }];
}

@end
