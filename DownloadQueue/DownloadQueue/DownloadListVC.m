//
//  DownloadListVC.m
//  DownloadQueue
//
//  Created by Xiangjian Meng on 15/7/23.
//  Copyright (c) 2015年 Modern Mobile Digital Media Company Limited. All rights reserved.
//

#import "DownloadListVC.h"
#import "DownloadHandler.h"
#import "ItemCell.h"

@interface DownloadListVC ()
{
    NSArray *dataArray;
    NSMutableDictionary *sessionIdDict;
}

@end

@implementation DownloadListVC

- (void)dealloc
{
    [[DownloadHandler sharedHandler] setDownloadingBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sessionIdDict = [NSMutableDictionary new];
    
    [[DownloadHandler sharedHandler] start];
    
    dataArray = [[DownloadHandler sharedHandler] downloadItemList];
    
    [dataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        DownloadItem *item = (DownloadItem *)obj;
        if (item)
        {
            if (item.sessionId != 0)
            {
                [sessionIdDict setObject:@(idx) forKey:@(item.sessionId)];
            }
        }
    }];
    
    [[DownloadHandler sharedHandler] setDownloadingBlock:^(NSUInteger sId, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger index = [[sessionIdDict objectForKey:@(sId)] integerValue];
            ItemCell *cell = (ItemCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
            if (cell)
            {
                cell.progressView.progress = progress;
            }
        });
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(addDownload)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)addDownload
{
    NSInteger count = [dataArray count];
    DownloadItem *item = [[DownloadItem alloc] initWithUrl:@"http://v.cdn.bbwc.cn/audio/bloomberg/2014/0325/20140325033418591.mp3"];
    NSUInteger sessionId = 0;
    [[DownloadHandler sharedHandler] addDownloadTaskWithItem:item sessionId:&sessionId];
    
    [sessionIdDict setObject:@(count) forKey:@(sessionId)];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                     forIndexPath:indexPath];
    
    // Configure the cell...
    DownloadItem *item = dataArray[indexPath.row];
    cell.progressView.progress = item.progress;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
