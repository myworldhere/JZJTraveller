//
//  JZJRequestCenter.h
//  JZJTraveller
//
//  Created by tarena on 15/12/10.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UITableView;
@interface JZJRequestCenter : NSObject
+(void)tableView:(UITableView*)tableView requestHttpUrl:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg onPage:(int)page forMutableArray:(NSMutableArray*)mutableArray;

@end
