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
+(NSURLRequest*)generateRequestByHttpUrl:(NSString*)httpUrl withHttpArg:(NSString*)HttpArg;

@end
