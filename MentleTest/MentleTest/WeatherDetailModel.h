//
//  WeatherDetailModel.h
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/5.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface WeatherDetailModel : MTLModel <MTLJSONSerializing>

@property (nonatomic,strong) NSString *main;
@property (nonatomic,strong) NSString *desc;

@end
