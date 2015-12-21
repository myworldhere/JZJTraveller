//
//  JZJTrain.h
//  JZJTraveller
//
//  Created by tarena on 15/12/14.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZJTrain : NSObject
@property (nonatomic,strong) NSString* trainType;
@property (nonatomic,strong) NSString* trainNo;
@property (nonatomic,strong) NSString* from;
@property (nonatomic,strong) NSString* to;
@property (nonatomic,strong) NSString* startTime;
@property (nonatomic,strong) NSString* endTime;
@property (nonatomic,strong) NSString* duration;
@property (nonatomic,strong) NSArray* seatInfos;
@property (nonatomic,getter=isUnfold) BOOL unfold;
@end
