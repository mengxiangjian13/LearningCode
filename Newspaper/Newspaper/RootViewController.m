//
//  RootViewController.m
//  Newspaper
//
//  Created by Xiangjian Meng on 13-12-13.
//  Copyright (c) 2013年 Xiangjian Meng. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    NSTextStorage *storage;
    NSLayoutManager *manager;
    UIScrollView *newsScrollView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    newsScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    newsScrollView.pagingEnabled = YES;
    [self.view addSubview:newsScrollView];
    
    
    //找到文字内容
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"content" withExtension:@"txt"];
    
    //形成attributedString （NSTextStorage 就是attributedString 的子类）
    storage = [[NSTextStorage alloc] initWithFileURL:fileUrl
                                             options:nil
                                  documentAttributes:nil
                                               error:nil];
    //建立layout manager
    manager = [[NSLayoutManager alloc] init];
    
    //storage 添加manager。 使manager可以根据storage分配界面。
    [storage addLayoutManager:manager];

    [self multiColumns];
    
}
- (void)multiColumns
{
    
    NSInteger last = 0;
    
    CGFloat offset = 0;
    
    while (last < manager.numberOfGlyphs) {
        
        CGRect oneColumnRect = CGRectMake(offset, 0, self.view.bounds.size.width / 2.0, self.view.bounds.size.height);
        
        NSTextContainer *container = [[NSTextContainer alloc] initWithSize:oneColumnRect.size];
        
        [manager addTextContainer:container];
        
        UITextView *textView = [[UITextView alloc] initWithFrame:oneColumnRect textContainer:container];
        
        textView.scrollEnabled = NO;
        
        [newsScrollView addSubview:textView];
        
        offset += CGRectGetWidth(oneColumnRect);
        
        last = NSMaxRange([manager glyphRangeForTextContainer:container]);
    }
    
    newsScrollView.contentSize = CGSizeMake(offset, newsScrollView.bounds.size.height);
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
