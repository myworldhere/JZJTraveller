//
//  JZJResort.h
//  JZJTraveller
//
//  Created by tarena on 15/12/12.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZJResort : NSObject
@property (nonatomic,strong) NSString* name;
@property (nonatomic,strong) NSDictionary* location;
@property (nonatomic,strong) NSString* telephone;
@property (nonatomic,strong) NSString* star;
@property (nonatomic,strong) NSString* url;
@property (nonatomic,strong) NSString* abstract;
@property (nonatomic,strong) NSString* resortDescription;
@property (nonatomic,strong) NSDictionary* ticket_info;

@end
