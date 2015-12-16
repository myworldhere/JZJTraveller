//
//  JZJNavigationItem.h
//  JZJTraveller
//
//  Created by tarena on 15/12/4.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZJNavigationItem : UIView
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
+(id)navigationBarView;
@end
