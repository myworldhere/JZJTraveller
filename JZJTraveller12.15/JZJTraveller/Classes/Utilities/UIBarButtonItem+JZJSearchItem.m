//
//  UIBarButtonItem+JZJSearchItem.m
//  JZJTraveller
//
//  Created by 麦沃德赫尔 on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "UIBarButtonItem+JZJSearchItem.h"
#import "JZJNavigationItem.h"
@implementation UIBarButtonItem (JZJSearchItem)

+(UIBarButtonItem *)generaterBarButtonItemWithCustomView:(JZJNavigationItem*)customeView Target:(id)target buttonAction:(SEL)action andTextfieldAction:(SEL)textAction
{
    UIBarButtonItem* item=[[UIBarButtonItem alloc]initWithCustomView:customeView];
    [customeView.searchButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [customeView.searchTextField addTarget:target action:action forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [customeView.searchTextField addTarget:target action:textAction forControlEvents:UIControlEventEditingDidBegin];
    return item;
}
@end
