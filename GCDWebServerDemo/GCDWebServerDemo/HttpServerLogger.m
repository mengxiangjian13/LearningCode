//
//  HttpServerLogger.m
//  GCDWebServerDemo
//
//  Created by mengxiangjian on 16/6/17.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#define kMinRefreshDelay 500

#import "HttpServerLogger.h"
#import <GCDWebServer/GCDWebServer.h>
#import <GCDWebServer/GCDWebServerDataResponse.h>
#import "SystemLogMessage.h"

@interface HttpServerLogger ()

@property (nonatomic, strong) GCDWebServer *webServer;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation HttpServerLogger

+ (instancetype)sharedLogger {
    static dispatch_once_t onceToken;
    static HttpServerLogger *shared = nil;
    dispatch_once(&onceToken, ^{
        shared = [HttpServerLogger new];
    });
    return shared;
}

- (GCDWebServer *)webServer {
    if (!_webServer) {
        _webServer = [GCDWebServer new];
        __weak __typeof__(self) weakSelf = self;
        // Add a handler to respond to GET requests on any URL
        [_webServer addDefaultHandlerForMethod:@"GET"
                                  requestClass:[GCDWebServerRequest class]
                                  processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
                                      return [weakSelf createResponseBody:request];
                                  }];
    }
    return _webServer;
}

- (void)startServer{

    /**
     *  server stat 方法，监听端口
     */
    [self.webServer startWithPort:8080 bonjourName:nil];
}

- (void)stopServer {
    // 停止server
    [_webServer stop];
    _webServer = nil;
}

//当浏览器请求的时候,返回一个由日志信息组装成的html返回给浏览器
- (GCDWebServerDataResponse *)createResponseBody :(GCDWebServerRequest* )request{
    GCDWebServerDataResponse *response = nil;
    
    NSString* path = request.path;
    NSDictionary* query = request.query;
    //NSLog(@"path = %@,query = %@",path,query);
    NSMutableString* string;
    if ([path isEqualToString:@"/"]) {
        string = [[NSMutableString alloc] init];
        [string appendString:@"<!DOCTYPE html><html lang=\"en\">"];
        [string appendString:@"<head><meta charset=\"utf-8\"></head>"];
        [string appendFormat:@"<title>%s[%i]</title>", getprogname(), getpid()];
        [string appendString:@"<style>\
         body {\n\
         margin: 0px;\n\
         font-family: Courier, monospace;\n\
         font-size: 0.8em;\n\
         }\n\
         table {\n\
         width: 100%;\n\
         border-collapse: collapse;\n\
         }\n\
         tr {\n\
         vertical-align: top;\n\
         }\n\
         tr:nth-child(odd) {\n\
         background-color: #eeeeee;\n\
         }\n\
         td {\n\
         padding: 2px 10px;\n\
         }\n\
         #footer {\n\
         text-align: center;\n\
         margin: 20px 0px;\n\
         color: darkgray;\n\
         }\n\
         .error {\n\
         color: red;\n\
         font-weight: bold;\n\
         }\n\
         </style>"];
        [string appendFormat:@"<script type=\"text/javascript\">\n\
         var refreshDelay = %i;\n\
         var footerElement = null;\n\
         function updateTimestamp() {\n\
         var now = new Date();\n\
         footerElement.innerHTML = \"Last updated on \" + now.toLocaleDateString() + \" \" + now.toLocaleTimeString();\n\
         }\n\
         function refresh() {\n\
         var timeElement = document.getElementById(\"maxTime\");\n\
         var maxTime = timeElement.getAttribute(\"data-value\");\n\
         timeElement.parentNode.removeChild(timeElement);\n\
         \n\
         var xmlhttp = new XMLHttpRequest();\n\
         xmlhttp.onreadystatechange = function() {\n\
         if (xmlhttp.readyState == 4) {\n\
         if (xmlhttp.status == 200) {\n\
         var contentElement = document.getElementById(\"content\");\n\
         contentElement.innerHTML = contentElement.innerHTML + xmlhttp.responseText;\n\
         updateTimestamp();\n\
         setTimeout(refresh, refreshDelay);\n\
         } else {\n\
         footerElement.innerHTML = \"<span class=\\\"error\\\">Connection failed! Reload page to try again.</span>\";\n\
         }\n\
         }\n\
         }\n\
         xmlhttp.open(\"GET\", \"/log?after=\" + maxTime, true);\n\
         xmlhttp.send();\n\
         }\n\
         window.onload = function() {\n\
         footerElement = document.getElementById(\"footer\");\n\
         updateTimestamp();\n\
         setTimeout(refresh, refreshDelay);\n\
         }\n\
         </script>", kMinRefreshDelay];
        [string appendString:@"</head>"];
        [string appendString:@"<body>"];
        [string appendString:@"<table><tbody id=\"content\">"];
        [self _appendLogRecordsToString:string afterAbsoluteTime:0.0];
        
        [string appendString:@"</tbody></table>"];
        [string appendString:@"<div id=\"footer\"></div>"];
        [string appendString:@"</body>"];
        [string appendString:@"</html>"];
        
        
    }
    else if ([path isEqualToString:@"/log"] && query[@"after"]) {
        string = [[NSMutableString alloc] init];
        double time = [query[@"after"] doubleValue];
        [self _appendLogRecordsToString:string afterAbsoluteTime:time];
        
    }
    else {
        string = [@" <html><body><p>无数据</p></body></html>" mutableCopy];
    }
    if (string == nil) {
        string = [@"" mutableCopy];
    }
    response = [GCDWebServerDataResponse responseWithHTML:string];
    return response;
}

- (void)_appendLogRecordsToString:(NSMutableString*)string afterAbsoluteTime:(double)time {
    __block double maxTime = time;
    NSArray<SystemLogMessage *>  *allMsg = [SystemLogMessage allLogAfterTime:time];
    [allMsg enumerateObjectsUsingBlock:^(SystemLogMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        const char* style = "color: dimgray;";
        NSString* formattedMessage = [self displayedTextForLogMessage:obj];
        [string appendFormat:@"<tr style=\"%s\">%@</tr>", style, formattedMessage];
        if (obj.timeInterval > maxTime) {
            maxTime = obj.timeInterval ;
        }
    }];
    [string appendFormat:@"<tr id=\"maxTime\" data-value=\"%f\"></tr>", maxTime];
    
}


- (NSString *)displayedTextForLogMessage:(SystemLogMessage *)msg{
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendFormat:@"<td>%@</td> <td>%@</td> <td>%@</td>",[self.formatter stringFromDate:msg.date],msg.sender, msg.messageText];
    return string;
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    }
    return _formatter;
}

@end
