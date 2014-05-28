//
//  ConfigureViewController.m
//  TextKitLearning
//
//  Created by Xiangjian Meng on 14-5-28.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "ConfigureViewController.h"

@interface ConfigureViewController ()
{
    NSTextStorage *topStorage;
    NSTextStorage *bottomStorage;
}

@end

@implementation ConfigureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *textFilePath = [[NSBundle mainBundle] pathForResource:@"lorem"
                                                             ofType:@"txt"];
    NSString *text = [[NSString alloc] initWithContentsOfFile:textFilePath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    topStorage = [[NSTextStorage alloc] initWithString:text];
    NSLayoutManager *topManager = [[NSLayoutManager alloc] init];
    [topStorage addLayoutManager:topManager];
    NSTextContainer *container = [[NSTextContainer alloc] init];
    [topManager addTextContainer:container];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)
                                               textContainer:container];
    textView.editable = NO;
    textView.textColor = [UIColor blackColor];
    textView.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView];
    
    bottomStorage = [[NSTextStorage alloc] initWithString:text];
    NSLayoutManager *bottomManager = [[NSLayoutManager alloc] init];
    [bottomStorage addLayoutManager:bottomManager];
    NSTextContainer *bottomLeftContainer = [[NSTextContainer alloc] init];
    [bottomManager addTextContainer:bottomLeftContainer];
    UITextView *leftView = [[UITextView alloc] initWithFrame:CGRectMake(0, 250, 160, 268)
                                               textContainer:bottomLeftContainer];
    leftView.editable = NO;
    leftView.scrollEnabled = NO;
    leftView.textColor = [UIColor blackColor];
    leftView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:leftView];
    
    NSTextContainer *bottomRightContainer = [[NSTextContainer alloc] init];
    [bottomManager addTextContainer:bottomRightContainer];
    UITextView *rightView = [[UITextView alloc] initWithFrame:CGRectMake(160, 250, 160, 268)
                                               textContainer:bottomRightContainer];
    rightView.backgroundColor = [UIColor blueColor];
    rightView.editable = NO;
    rightView.textColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
