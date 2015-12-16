//
//  JZJSeatInfosTableViewCell.m
//  JZJTraveller
//
//  Created by tarena on 15/12/15.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "JZJSeatInfosTableViewCell.h"
#import "JZJSeatInfo.h"
@interface JZJSeatInfosTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *seatLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *seatPriceLabel;

@end
@implementation JZJSeatInfosTableViewCell

- (void)setSeatInfo:(JZJSeatInfo *)seatInfo
{
    _seatInfo=seatInfo;
    self.seatLabel.text=_seatInfo.seat;
    self.remainNumLabel.text=[NSString stringWithFormat:@"%@张",_seatInfo.remainNum];
    self.seatPriceLabel.text=[NSString stringWithFormat:@"%@元",_seatInfo.seatPrice];
}

@end
