//
//  JZJRequestCenter.m
//  JZJTraveller
//
//  Created by tarena on 15/12/10.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJRequestCenter.h"
#import <UIKit/UIKit.h>
#import "JZJDataManager.h"
@interface JZJRequestCenter()
@property (nonatomic,strong) NSURLSessionDataTask* task;

@end
@implementation JZJRequestCenter


+(void)tableView:(UITableView *)tableView requestHttpUrl:(NSString *)httpUrl withHttpArg:(NSString *)HttpArg onPage:(int)page forMutableArray:(NSMutableArray *)mutableArray
{
    [[JZJRequestCenter alloc]initTableView:tableView requestHttpUrl:httpUrl withHttpArg:HttpArg onPage:page forMutableArray:mutableArray];
}

-(void)initTableView:(UITableView*)tableView requestHttpUrl: (NSString*)httpUrl withHttpArg: (NSString*)HttpArg onPage:(int)page forMutableArray:(NSMutableArray*)mutableArray
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"5a9455242f3f74e42f972f2f9323e33a" forHTTPHeaderField: @"apikey"];
    
    self.task=[[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"HttpError:%@",error.userInfo);
            //            [tableView.bottomRefreshControl endRefreshing];
        }
        else
        {
            NSInteger responseCode=[(NSHTTPURLResponse*)response statusCode];
            if (responseCode==200)
            {
                if (page==1)
                {
                    [mutableArray removeAllObjects];
                }
                [mutableArray addObjectsFromArray:[JZJDataManager getBooksFromData:data]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                    //                    [tableView.bottomRefreshControl endRefreshing];
                });
            }
        }
    }];
    [self.task resume];
}




@end
