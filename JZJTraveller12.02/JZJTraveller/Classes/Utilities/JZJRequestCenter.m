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

@end
@implementation JZJRequestCenter


+(NSURLRequest *)generateRequestByHttpUrl:(NSString *)httpUrl withHttpArg:(NSString *)HttpArg
{
    return [[JZJRequestCenter alloc]requestByHttpUrl:httpUrl withHttpArg:HttpArg];
}

-(NSURLRequest*)requestByHttpUrl:(NSString *)httpUrl withHttpArg:(NSString *)HttpArg
{
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, HttpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"5a9455242f3f74e42f972f2f9323e33a" forHTTPHeaderField: @"apikey"];
    
    return [request copy];
}




@end
