//
//  CustomViewController.m
//  PodTest
//
//  Created by Xiangjian Meng on 14/12/2.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "CustomViewController.h"

#define PROPERTY_NAME @"com.mengxiangjian.volume"

@interface CustomViewController ()
{
    UILabel *volumeLabel;
}

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"custom";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 200, 50);
    [button setTitle:@"animate volume!" forState:UIControlStateNormal];
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) + 100);
    [button addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    volumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    volumeLabel.center = self.view.center;
    volumeLabel.textAlignment = NSTextAlignmentCenter;
    volumeLabel.text = @"0";
    volumeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:volumeLabel];
    
    
}

- (void)animate:(id)sender
{
    [volumeLabel pop_removeAllAnimations];
    volumeLabel.text = @"0";
    
    POPSpringAnimation *animation = [POPSpringAnimation animation];
    animation.fromValue = @0;
    animation.toValue = @100;
    animation.springBounciness = 10;
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:PROPERTY_NAME
                                                              initializer:^(POPMutableAnimatableProperty *prop) {
                                                                  prop.readBlock = ^(id obj, CGFloat values[]){
                                                                      values[0] = 0.0;
                                                                  };
                                                                  prop.writeBlock = ^(id obj, const CGFloat values[]){
                                                                      if ([obj isKindOfClass:[UILabel class]])
                                                                      {
                                                                          UILabel *label = (UILabel *)obj;
                                                                          label.text = [NSString stringWithFormat:@"%.2f",values[0]];
                                                                      }
                                                                  };
                                                                  
                                                                  prop.threshold = 0.01;
                                                              }];
    
    animation.property = prop;
    [volumeLabel pop_addAnimation:animation forKey:@"customAnimation"];
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
