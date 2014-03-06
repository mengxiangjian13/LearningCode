//
//  MyURLProtocol.m
//  NSURLProtocolExample
//
//  Created by yizelin on 14-3-5.
//  Copyright (c) 2014年 Rocir Santiago. All rights reserved.
//

#import "MyURLProtocol.h"
#import "AppDelegate.h"
#import "CachedURLResponse.h"

@interface MyURLProtocol () <NSURLConnectionDelegate>
@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *mutableData;
@property (nonatomic, strong) NSURLResponse *response;
@end

@implementation MyURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    static NSUInteger requestCount = 0;
    NSLog(@"Request #%u : URL = %@",requestCount ++,request.URL.absoluteString);
    
    if ([[NSURLProtocol propertyForKey:@"MyURLProtocolHandledKey" inRequest:request] boolValue])
    {
        return NO;
    }

    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b
{
    return [super requestIsCacheEquivalent:a toRequest:b];
}

- (void)startLoading
{
    CachedURLResponse *cachedResponse = [self cachedResponseForCurrentRequest];
    
    if (cachedResponse)
    {
         NSLog(@"serving response from cache");
        
        //有缓存
        NSData *data = cachedResponse.data;
        NSString *mimeType = cachedResponse.mimeType;
        NSString *encoding = cachedResponse.encoding;
        
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
                                                            MIMEType:mimeType
                                               expectedContentLength:data.length
                                                    textEncodingName:encoding];
        
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [self.client URLProtocol:self didLoadData:data];
        [self.client URLProtocolDidFinishLoading:self];
    }
    else
    {
        NSLog(@"serving response from NSURLConnection");
        
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        [NSURLProtocol setProperty:[NSNumber numberWithBool:YES] forKey:@"MyURLProtocolHandledKey" inRequest:newRequest];
        
        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
    }
    
    
}

- (void)stopLoading
{
    [self.connection cancel];
    self.connection = nil;
}


//connection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    self.response = response;
    self.mutableData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
    [self.mutableData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
    [self saveCachedResponse];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
}

- (void)saveCachedResponse
{
    //缓存
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    CachedURLResponse *cachedResponse = [NSEntityDescription insertNewObjectForEntityForName:@"CachedURLResponse"
                                                                      inManagedObjectContext:context];
    cachedResponse.data = self.mutableData;
    cachedResponse.url = self.request.URL.absoluteString;
    cachedResponse.timestamp = [NSDate date];
    cachedResponse.mimeType = self.response.MIMEType;
    cachedResponse.encoding = self.response.textEncodingName;
    
    NSError *error = nil;
    BOOL const success = [context save:&error];
    if (!success)
    {
        NSLog(@"could not cache the response");
    }
    
}

- (CachedURLResponse *)cachedResponseForCurrentRequest
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"CachedURLResponse"
                                                   inManagedObjectContext:context];
    [fetchRequest setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"url == %@",self.request.URL.absoluteString];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetchRequest
                                             error:&error];
    
    if (result && [result count] > 0)
    {
        return result[0];
    }
    
    return nil;
    
}

@end
