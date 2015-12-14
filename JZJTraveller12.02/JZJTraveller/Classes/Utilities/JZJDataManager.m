//
//  JZJDataManager.m
//  JZJTraveller
//
//  Created by tarena on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJDataManager.h"
#import "JZJBooks.h"
#import "JZJResort.h"
#import "JZJTicketInformation.h"
#import "JZJTicketAttention.h"
#import "JZJTrain.h"
@implementation JZJDataManager


#pragma mark - 解析并获取热门游记博文
+(NSArray *)getBooksFromData:(id)data{
    
    return  [[self alloc]parseJSONDataForClass:[JZJBooks class] WithData:data];
}

///解析JSON数据，并获取数组数据
-(NSArray *)parseJSONDataForClass:(Class)className WithData:(id)data
{
    NSMutableArray* mutableArray=[@[]mutableCopy];
    for (NSDictionary* dict in data)
    {
        id instance = [className new];
        [instance setValuesForKeysWithDictionary:dict];
        [mutableArray addObject:instance];
    }
    return [mutableArray copy];
}

#pragma mark - 解析并获取景点详情
+(JZJResort *)getResortsFromData:(id)data
{
    return [[self alloc]parseJSONDataForResortFromData:data];
}

-(JZJResort *)parseJSONDataForResortFromData:(id)data
{
    JZJResort* resort=[JZJResort new];
    [resort setValuesForKeysWithDictionary:data];
    return resort;
}
#pragma mark - 解析并获取票务信息
+(JZJTicketInformation *)getTicketInformationOfResort:(NSDictionary *)tick_infoDict{
    JZJTicketInformation* information=[[JZJTicketInformation alloc]init];
    [information setValuesForKeysWithDictionary:tick_infoDict];
    return information;
}

+(NSArray *)getTicketAttentionOfTicketInformation:(NSArray *)attentionArray{
    
    NSMutableArray* attentionMutableArray=[@[]mutableCopy];
    for (NSDictionary* attentionDict in attentionArray)
    {
        JZJTicketAttention* attention=[JZJTicketAttention new];
        [attention setValuesForKeysWithDictionary:attentionDict];
        [attentionMutableArray addObject:attention];
    }
    return [attentionMutableArray copy];
}
#pragma  mark - 解析列车信息列表
+(NSArray *)getTrainList:(id)data
{
    return [[self alloc]parseJSONDataForClass:[JZJTrain class] WithData:data];
}

@end
