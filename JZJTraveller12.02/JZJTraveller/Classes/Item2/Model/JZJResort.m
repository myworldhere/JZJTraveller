//
//  JZJResort.m
//  JZJTraveller
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJResort.h"

@implementation JZJResort
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"])
    {
        self.resortDescription=value;
    }
}
@end
