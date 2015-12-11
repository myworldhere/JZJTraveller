//
//  JZJDataManager.m
//  JZJTraveller
//
//  Created by tarena on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJDataManager.h"
#import "JZJBooks.h"

@implementation JZJDataManager

+(NSArray *)getBooksFromData:(id)data{
    
       return  [[self alloc]parseJSONDataWithData:data];
}
-(NSArray*)parseJSONDataWithData:(id)data
{
    NSDictionary* Originaldict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray* BookArray=Originaldict[@"data"][@"books"];
    NSMutableArray* mutableArray=[@[]mutableCopy];
    for (NSDictionary* dict in BookArray)
    {
        JZJBooks* book=[JZJBooks new];
        [book setValuesForKeysWithDictionary:dict];
        [mutableArray addObject:book];
    }
    return [mutableArray copy];
}
@end
