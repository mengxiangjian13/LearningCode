//
//  ViewController.m
//  MentleTest
//
//  Created by Xiangjian Meng on 14/12/3.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"
#import "WeatherModel.h"
#import "WeatherDetailModel.h"

#define Beijing_Weather_API @"http://api.openweathermap.org/data/2.5/weather?lat=40&lon=116&units=imperial"

@interface ViewController ()
{
    NSURLSession *urlSession;
    NSDictionary *currentData;
}

@property (nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (!urlSession)
    {
        urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
}

// 请求数据
- (IBAction)requestCurrentWeather:(id)sender
{
    // 利用NSURLSessionTask发送请求
    NSURLSessionTask *task = [urlSession dataTaskWithURL:[NSURL URLWithString:Beijing_Weather_API]
                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                           id json = [NSJSONSerialization JSONObjectWithData:data
                                                                                     options:NSJSONReadingAllowFragments
                                                                                       error:nil];
                                           if ([json isKindOfClass:[NSDictionary class]])
                                           {
                                               currentData = (NSDictionary *)json;
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   self.textView.text = currentData.description;
                                               });
                                           }
                                           ;
                                       }];
    [task resume];
}

- (IBAction)showMantleModel:(id)sender
{
    if (currentData)
    {
        WeatherModel *model = [MTLJSONAdapter modelOfClass:[WeatherModel class] fromJSONDictionary:currentData error:nil];
        WeatherDetailModel *detail = (model.detail.count > 0)?[model.detail objectAtIndex:0] : nil;
        self.textView.text = [NSString stringWithFormat:@"当前温度：%.2f\n日出时间：%@\n天气描述：%@",model.temperature.floatValue,model.sunrise, detail.desc];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
