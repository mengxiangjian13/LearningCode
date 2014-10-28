//
//  ActivityModel.h
//  NewCoreMotion
//
//  Created by Xiangjian Meng on 14/10/28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    ActivityModelTypeUnknow = 0,
    ActivityModelTypeStationary,
    ActivityModelTypeCycling,
    ActivityModelTypeAutomotive,
    ActivityModelTypeWalking,
    ActivityModelTypeRunning,
}ActivityModelType;

@interface ActivityModel : NSObject

@property (nonatomic,assign) ActivityModelType type;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSDate *startDate;

@end
