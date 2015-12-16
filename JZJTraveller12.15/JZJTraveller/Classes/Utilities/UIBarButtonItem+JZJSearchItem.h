//
//  UIBarButtonItem+JZJSearchItem.h
//  JZJTraveller
//
//  Created by 麦沃德赫尔 on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZJNavigationItem;
@interface UIBarButtonItem (JZJSearchItem)
+(UIBarButtonItem *)generaterBarButtonItemWithCustomView:(JZJNavigationItem*)customeView Target:(id)target buttonAction:(SEL)action andTextfieldAction:(SEL)textAction;
@end
