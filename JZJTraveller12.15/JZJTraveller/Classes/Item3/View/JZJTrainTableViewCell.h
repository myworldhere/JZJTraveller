//
//  JZJTrainTableViewCell.h
//  JZJTraveller
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JZJTrain;
@interface JZJTrainTableViewCell : UITableViewCell
@property (nonatomic,strong) JZJTrain* trainInfo;
-(void)setArrowImageViewWhitIfUnfold:(BOOL)unfold;
@end
