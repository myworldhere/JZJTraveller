//
//  JZJTicketAttention.m
//  JZJTraveller
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJTicketAttention.h"

@implementation JZJTicketAttention
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        self.attentionDescription=value;
    }
}
@end
