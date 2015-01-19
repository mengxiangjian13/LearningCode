//
//  ViewController.m
//  TLSTest
//
//  Created by Xiangjian Meng on 15/1/19.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import <Security/Security.h>

@interface ViewController () <NSURLSessionDelegate>
{
    NSURLSession *session;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                            delegate:self
                                       delegateQueue:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://192.168.59.103:2376/images/json"]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                NSString *string = [[NSString alloc] initWithData:data
                                                                                         encoding:NSUTF8StringEncoding];
                                                NSLog(@"%@",string);
                                            }];
    [task resume];
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    NSString *p12Path = [[NSBundle mainBundle] pathForResource:@"identity" ofType:@"p12"];
    NSData *data = [NSData dataWithContentsOfFile:p12Path];
    CFStringRef pw = (__bridge CFStringRef)@"123456";
    
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;
    
    extractIdentityAndTrust((__bridge CFDataRef)data, &identity, &trust, pw);
    if (identity != NULL)
    {
        SecCertificateRef myCer = NULL;
        extractCertificate(identity, &myCer);
        
        if (completionHandler)
        {
            id cer = (__bridge id)myCer;
            NSURLCredential *credetial = [NSURLCredential credentialWithIdentity:identity
                                                                    certificates:@[cer]
                                                                     persistence:NSURLCredentialPersistencePermanent];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credetial);
        }
    }
}

OSStatus extractIdentityAndTrust(CFDataRef inPKCS12Data,
                                 SecIdentityRef *outIdentity,
                                 SecTrustRef *outTrust,
                                 CFStringRef keyPassword)
{
    OSStatus securityError = errSecSuccess;
    
    
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { keyPassword };
    CFDictionaryRef optionsDictionary = NULL;
    
    /* Create a dictionary containing the passphrase if one
     was specified.  Otherwise, create an empty dictionary. */
    optionsDictionary = CFDictionaryCreate(
                                           NULL, keys,
                                           values, (keyPassword ? 1 : 0),
                                           NULL, NULL);  // 1
    
    CFArrayRef items = NULL;
    securityError = SecPKCS12Import(inPKCS12Data,
                                    optionsDictionary,
                                    &items);                    // 2
    
    
    //
    if (securityError == 0) {                                   // 3
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,
                                             kSecImportItemIdentity);
        CFRetain(tempIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        
        CFRetain(tempTrust);
        *outTrust = (SecTrustRef)tempTrust;
    }
    
    if (optionsDictionary)                                      // 4
        CFRelease(optionsDictionary);
    
    if (items)
        CFRelease(items);
    
    return securityError;
}

OSStatus extractCertificate(SecIdentityRef identity,
                            SecCertificateRef *certificate)
{
    OSStatus status = SecIdentityCopyCertificate (identity,
                                                  certificate);
    return status;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
