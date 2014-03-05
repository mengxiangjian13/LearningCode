//
//  CachedURLResponse.h
//  NSURLProtocolExample
//
//  Created by yizelin on 14-3-5.
//  Copyright (c) 2014年 Rocir Santiago. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CachedURLResponse : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * encoding;
@property (nonatomic, retain) NSString * mimeType;
@property (nonatomic, retain) NSString * url;

@end
