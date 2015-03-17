//
//  AttachmentViewController.m
//  TextKitLearning
//
//  Created by Xiangjian Meng on 15/3/17.
//  Copyright (c) 2015年 cn.com.modernmedia. All rights reserved.
//

#import "AttachmentViewController.h"

@interface AttachmentViewController ()

@end

@implementation AttachmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@" 老孟是个程序员"
                                                              attributes:nil];
    
    
    
    
    NSAttributedString *redstring = [[NSAttributedString alloc] initWithString:@"@北航工科女郭小燕子" attributes:@{NSBackgroundColorAttributeName : [UIColor redColor]}];
    [str insertAttributedString:redstring atIndex:1];
    
    NSTextAttachment *att = [[NSTextAttachment alloc] init];
    att.image = [UIImage imageNamed:@"da"];
    NSAttributedString *daImage = [NSAttributedString attributedStringWithAttachment:att];
    
    [str insertAttributedString:daImage atIndex:0];
    
    textView.attributedText = str;
    [self.view addSubview:textView];
    
    NSLog(@"%@",str.string);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
