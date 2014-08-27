//
//  RootViewController.m
//  GLKitLearning
//
//  Created by Xiangjian Meng on 14-8-27.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<GLKViewDelegate,GLKViewControllerDelegate>
{
    CGFloat curRed;
    BOOL isIncreasing;
    EAGLContext *context;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    if ([EAGLContext currentContext] == context)
    {
        [EAGLContext setCurrentContext:nil];
    }
    
    context = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    isIncreasing = YES;
    curRed = 0.0;
    
    context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    GLKView *view = [[GLKView alloc] initWithFrame:self.view.bounds
                                           context:context];
    self.view = view;
    
    self.preferredFramesPerSecond = 60;
    
    self.delegate = self;
    view.delegate = self;
    
}

// GLKViewDelegate
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    // 将GLKView清理成红色
    glClearColor(curRed, 0.0, 0.0, 1.0);
    // 真正的清理方法，清理颜色缓冲区
    glClear(GL_COLOR_BUFFER_BIT);
}

// GLKViewControllerDelegate
- (void)glkViewControllerUpdate:(GLKViewController *)controller
{
    if (isIncreasing)
    {
        curRed += 1.0 * controller.timeSinceLastUpdate;
        if (curRed >= 1)
        {
            isIncreasing = NO;
        }
    }
    else
    {
        curRed -= 1.0 * controller.timeSinceLastUpdate;
        if (curRed <= 0)
        {
            isIncreasing = YES;
        }
    }
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
