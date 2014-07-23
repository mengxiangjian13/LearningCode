//
//  RootViewController.m
//  ImagePickerTest
//
//  Created by Xiangjian Meng on 14-7-23.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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
    
    UIButton *libraryButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [libraryButton setTitle:@"照片库" forState:UIControlStateNormal];
    libraryButton.frame = CGRectMake(100, 100, 100, 50);
    [libraryButton addTarget:self action:@selector(showLib:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:libraryButton];
    
    UIButton *videoLibButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [videoLibButton setTitle:@"视频库" forState:UIControlStateNormal];
    videoLibButton.frame = CGRectMake(100, 200, 100, 50);
    [videoLibButton addTarget:self action:@selector(showVideoLib:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoLibButton];
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [photoButton setTitle:@"拍照片" forState:UIControlStateNormal];
    photoButton.frame = CGRectMake(100, 300, 100, 50);
    [photoButton addTarget:self action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
    UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [videoButton setTitle:@"拍视频" forState:UIControlStateNormal];
    videoButton.frame = CGRectMake(100, 400, 100, 50);
    [videoButton addTarget:self action:@selector(video:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:videoButton];
}

- (void)showLib:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)showVideoLib:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];//只提取视频
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)photo:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)video:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeMovie];//只拍视频
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
    {
        //浏览相关
        if ([picker.mediaTypes firstObject] == (NSString *)kUTTypeMovie)
        {
            //浏览视频
            NSURL *movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
            if (movieURL)
            {
                NSLog(@"scan movieURL:%@",movieURL);
                NSData *data = [NSData dataWithContentsOfURL:movieURL];
                if (data)
                {
                    NSLog(@"获取到movie的data");
                }
            }
        }
        else
        {
            //浏览照片
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            if (image)
            {
                NSLog(@"浏览并选择了image");
            }
        }
    }
    else
    {
        //拍摄相关
        if ([picker.mediaTypes firstObject] == (NSString *)kUTTypeMovie)
        {
            //拍摄视频
            NSURL *movieURL = [info objectForKey:UIImagePickerControllerMediaURL];
            if (movieURL)
            {
                NSLog(@"take movieURL:%@",movieURL);
                NSData *data = [NSData dataWithContentsOfURL:movieURL];
                if (data)
                {
                    NSLog(@"获取到movie的data");
                }
            }
        }
        else
        {
            //拍摄照片
            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
            if (image)
            {
                NSLog(@"拍摄并选择了image");
            }
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
