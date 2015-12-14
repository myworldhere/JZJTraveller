//
//  JZJDataManager.h
//  JZJTraveller
//
//  Created by tarena on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JZJBooks;
@class JZJResort;
@class JZJTicketInformation;
@class JZJTicketAttention;
@class JZJTrain;
@interface JZJDataManager : NSObject
+(NSArray *)getBooksFromData:(id)data;
+(JZJResort *)getResortsFromData:(id)data;
+(JZJTicketInformation*)getTicketInformationOfResort:(NSDictionary*)tick_infoDict;
+(NSArray*)getTicketAttentionOfTicketInformation:(NSArray*)attentionArray;
+(NSArray*)getTrainList:(id)data;
@end
