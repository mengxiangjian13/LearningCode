//
//  TableInterfaceController.m
//  WatchKitCatalog
//
//  Created by Xiangjian Meng on 14/11/26.
//  Copyright (c) 2014年 cn.com.modernmedia. All rights reserved.
//

#import "TableInterfaceController.h"
#import "TableInterfaceRowController.h"

@interface TableInterfaceController ()
{
    NSMutableArray *locations;
}

@property (weak, nonatomic) IBOutlet WKInterfaceTable *table;

@end

@implementation TableInterfaceController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        locations = [[NSMutableArray alloc] initWithObjects:@"Beijing",@"Handan",@"Tianjin",@"Harbin", nil];
        [self.table setNumberOfRows:[locations count]
                        withRowType:@"RowController"];
        for (NSInteger i = 0; i < [locations count]; i ++)
        {
            TableInterfaceRowController *cell = (TableInterfaceRowController *)[self.table rowControllerAtIndex:i];
            [cell.locationLabel setText:locations[i]];
        }
    }
    return self;
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex
{
    NSString *location = locations[rowIndex];
    if ([location isEqualToString:@"Handan"])
    {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[locations count]];
        [self.table insertRowsAtIndexes:indexSet withRowType:@"RowController"];
        
        TableInterfaceRowController *newCell = [self.table rowControllerAtIndex:[locations count]];
        if (newCell)
        {
            [newCell.locationLabel setText:@"My Home"];
        }
        [locations addObject:@"My Home"];
    }
    
}

- (void)willActivate
{
    
}

- (void)didDeactivate
{
    
}

@end
