//
//  ViewController.m
//  RegExLearning
//
//  Created by Xiangjian Meng on 14/12/16.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *sourceWordsField;
@property (weak, nonatomic) IBOutlet UITextField *regExField;
@property (weak, nonatomic) IBOutlet UIButton *matchButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.matchButton addTarget:self action:@selector(match) forControlEvents:UIControlEventTouchUpInside];
}

- (void)match
{
    if (self.sourceWordsField.text.length > 0 && self.regExField.text.length > 0)
    {
        NSError *error = nil;
        NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:self.regExField.text
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:&error];

        NSArray *matchStringArray = [expression matchesInString:self.sourceWordsField.text
                                                        options:NSMatchingReportProgress // 只要有一个匹配就停止
                                                          range:NSMakeRange(0, self.sourceWordsField.text.length)];
        if ([matchStringArray count] > 0)
        {
            NSTextCheckingResult *result = matchStringArray[0];
            NSLog(@"range(%ld,%ld)",result.range.location,result.range.length);
            self.resultLabel.text = [self.sourceWordsField.text substringWithRange:result.range];
        }
        else
        {
            self.resultLabel.text = nil;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
