//
//  JZJBooks.h
//  JZJTraveller
//
//  Created by tarena on 15/12/1.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZJBooks : NSObject
@property (nonatomic,strong) NSString* bookUrl;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* headImage;
@property (nonatomic,strong) NSString* userName;
@property (nonatomic,strong) NSString* userHeadImg;
@property (nonatomic,strong) NSString* startTime;
@property (nonatomic,strong) NSNumber* routeDays;
@property (nonatomic,strong) NSNumber* bookImgNum;
@property (nonatomic,strong) NSNumber* viewCount;
@property (nonatomic,strong) NSNumber* likeCount;
@property (nonatomic,strong) NSNumber* commentCount;
@property (nonatomic,strong) NSString* text;
@property (nonatomic,assign) BOOL elite;
@end
