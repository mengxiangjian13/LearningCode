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

@interface DownloadListVC () <ItemCellDelegate>
{
    NSArray *dataArray;
}

@end

@implementation DownloadListVC

- (void)dealloc
{
    [[DownloadHandler sharedHandler] setDownloadingBlock:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DownloadHandler sharedHandler] start];
    
    dataArray = [[DownloadHandler sharedHandler] downloadItemList];
    
    [[DownloadHandler sharedHandler] setDownloadingBlock:^(DownloadItem *item) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger index = [dataArray indexOfObject:item];
            if (index != NSNotFound)
            {
                ItemCell *cell = (ItemCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
                if (cell)
                {
                    cell.progressView.progress = item.progress;
                }
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
    DownloadItem *item = [[DownloadItem alloc] initWithUrl:@"http://v.cdn.bbwc.cn/audio/bloomberg/2014/0325/20140325033418591.mp3" userInfo:nil];
    [[DownloadHandler sharedHandler] addDownloadTaskWithItem:item];
    
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
    
    cell.delegate = self;
    // Configure the cell...
    DownloadItem *item = dataArray[indexPath.row];
    cell.progressView.progress = item.progress;
    
    [self setButtonTitleForCell:cell state:item.state];
    
    return cell;
}


- (void)itemCellDidTouchPauseButtonWithCell:(ItemCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    if (indexPath)
    {
        if (indexPath.row >= 0 && indexPath.row < [dataArray count])
        {
            DownloadItem *item = [dataArray objectAtIndex:indexPath.row];
            DownloadItemState state = item.state;
            if (state == DownloadItemStateDownloading)
            {
                [[DownloadHandler sharedHandler] pauseDownloadTaskWithSessionId:item.sessionId];
                [self setButtonTitleForCell:cell state:DownloadItemStatePause];
            }
            else if (state == DownloadItemStateNotStart)
            {
                [[DownloadHandler sharedHandler] startDownloadTaskWithItem:item];
                [self setButtonTitleForCell:cell state:DownloadItemStateDownloading];
            }
            else if (state == DownloadItemStatePause)
            {
                [[DownloadHandler sharedHandler] resumeDownloadTaskWithSessionId:item.sessionId];
                [self setButtonTitleForCell:cell state:DownloadItemStateDownloading];
            }
        }
    }
}

- (void)setButtonTitleForCell:(ItemCell *)cell state:(DownloadItemState)state
{
    if (state == DownloadItemStateDownloading)
    {
        [cell setButtonTitle:@"暂停"];
    }
    else if (state == DownloadItemStateNotStart)
    {
        [cell setButtonTitle:@"下载"];
    }
    else if (state == DownloadItemStatePause)
    {
        [cell setButtonTitle:@"继续"];
    }
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
