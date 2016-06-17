//
//  ViewController.m
//  GCDWebServerDemo
//
//  Created by mengxiangjian on 16/6/17.
//  Copyright © 2016年 mengxiangjian. All rights reserved.
//

#import "ViewController.h"
#import "HttpServerLogger.h"

@interface ViewController () <UITextFieldDelegate>
{
    HttpServerLogger *logger;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    logger = [[HttpServerLogger alloc] init];
    _textField.delegate = self;
    
}
- (IBAction)startServer:(id)sender {
    [logger startServer];
}

- (IBAction)stopServer:(id)sender {
    [logger stopServer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%@",textField.text);
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
