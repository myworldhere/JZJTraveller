//
//  JZJNavigationItem.m
//  JZJTraveller
//
//  Created by tarena on 15/12/4.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJNavigationItem.h"

@implementation JZJNavigationItem
+(id)navigationBarView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"JZJNavigationItem" owner:nil options:nil]lastObject];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        self.autoresizingMask=UIViewAutoresizingNone;
    }
    return self;
}
@end
